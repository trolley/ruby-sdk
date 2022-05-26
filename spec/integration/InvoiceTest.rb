require_relative 'helper'

class InvoiceTest < Test::Unit::TestCase
  def setup
    @client = PaymentRails.client(
      ENV.fetch('SANDBOX_API_KEY'),
      ENV.fetch('SANDBOX_SECRET_KEY'),
      ENV.fetch('TROLLEY_ENVIRONMENT'),
      proxy_uri: ENV['PROXY_URI']
    )
  end

  def create_recipient
    uuid = SecureRandom.uuid.to_s
    recipient = @client.recipient.create(
      type: 'individual',
      firstName: 'Tom',
      lastName: 'Jones',
      email: 'test.batch' + uuid + '@example.com',
      address: {
        street1: '123 Wolfstrasse',
        city: 'Berlin',
        country: 'DE',
        postalCode: '123123'
      }
    )
    @client.recipient_account.create(recipient.id, type: 'bank-transfer', currency: 'EUR', country: 'DE', iban: 'DE89 3704 0044 0532 0130 00')
    recipient
  end

  def test_create
    recipient = create_recipient
    invoice = @client.invoice.create(recipientId: recipient.id, description: 'Integration Test Invoice Create')
    assert_not_nil(invoice)
    assert_not_nil(invoice.id)

    invoice = @client.invoice.search({})
    assert_true(invoice.count > 0)
  end

  def test_create_line
    recipient = create_recipient
    invoice = @client.invoice.create(recipientId: recipient.id, description: 'Integration Test Invoice Create')
    assert_not_nil(invoice)
    assert_not_nil(invoice.id)
    assert_equal([], invoice.lines)

    invoice_line = @client.invoice.create_line(invoiceId: invoice.id, lines: [{ unitAmount: { value: '2000', currency: 'USD' } }])
    assert_not_nil(invoice_line.lines)
    assert_not_nil(invoice_line.lines.first['id'])

    findInvoice = @client.invoice.find(invoiceId: invoice.id)
    assert_true(findInvoice.lines.count > 0)
  end

  def test_update
    recipient = create_recipient
    invoice = @client.invoice.create(recipientId: recipient.id, description: 'Integration Test Invoice Create')
    assert_not_nil(invoice)
    assert_not_nil(invoice.id)

    invoices = @client.invoice.search({})
    assert_true(invoices.count > 0)

    response = @client.invoice.update(invoiceId: invoice.id, description: 'Integration Test Invoice Update')
    assert_true(response)
    findInvoice = @client.invoice.find(invoiceId: invoice.id)
    assert_equal('Integration Test Invoice Update', findInvoice.description)
    assert_equal('open', findInvoice.status)
  end

  def test_update_line
    recipient = create_recipient
    invoice = @client.invoice.create(recipientId: recipient.id, description: 'Integration Test Invoice Create')
    assert_not_nil(invoice)
    assert_not_nil(invoice.id)
    assert_equal([], invoice.lines)

    invoice_line = @client.invoice.create_line(invoiceId: invoice.id, lines: [{ unitAmount: { value: '2000', currency: 'USD' } }])
    assert_not_nil(invoice_line.lines)
    assert_not_nil(invoice_line.lines.first['id'])

    response = @client.invoice.update_line(
      invoiceId: invoice.id,
      lines: [{
        invoiceLineId: invoice_line.lines.first['id'],
        unitAmount: { value: '3000', currency: 'USD' }
      }]
    )
    assert_true(response)

    findInvoice = @client.invoice.find(invoiceId: invoice.id)
    assert_equal('3000.00', findInvoice.lines.first['unitAmount']['value'])
  end

  def test_delete
    recipient = create_recipient
    invoice = @client.invoice.create(recipientId: recipient.id, description: 'Integration Test Invoice Create')
    assert_not_nil(invoice)
    assert_not_nil(invoice.id)

    invoices = @client.invoice.search({})
    assert_true(invoices.count > 0)

    response = @client.invoice.delete(invoiceIds: invoices.map(&:id))
    assert_true(response)

    final_invoices = @client.invoice.search({})
    assert_true(final_invoices.count == 0)
  end

  def test_delete_line
    recipient = create_recipient
    invoice = @client.invoice.create(recipientId: recipient.id, description: 'Integration Test Invoice Create')
    assert_not_nil(invoice)
    assert_not_nil(invoice.id)
    assert_equal([], invoice.lines)

    invoice_line = @client.invoice.create_line(invoiceId: invoice.id, lines: [{ unitAmount: { value: '2000', currency: 'USD' } }])

    response = @client.invoice.delete_line(invoiceId: invoice.id, invoiceLineIds: [invoice_line.lines.first['id']])
    assert_true(response)
  end
end
