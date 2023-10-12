require_relative '../test_helper'

class InvoicePaymentTest < Test::Unit::TestCase
  include TestHelper

  def create_recipient
    uuid = SecureRandom.uuid.to_s
    recipient = @client.recipient.create(
      type: 'individual',
      firstName: 'Tom',
      lastName: 'Jones',
      email: "test.batch#{uuid}@example.com",
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

  def test_find
    with_vcr do
      recipient = create_recipient
      invoice = @client.invoice.create(recipientId: recipient.id, description: 'Integration Test Invoice Create')
      @client.invoice.create_line(invoiceId: invoice.id, lines: [{ unitAmount: { value: '2000', currency: 'USD' } }])
      @client.invoice_payment.create(ids: [invoiceId: invoice.id])
      invoice_payments = @client.invoice_payment.search({invoiceIds: [invoice.id]})
      assert_true(invoice_payments.count.positive?)
    end
  end

  def test_create
    with_vcr do
      recipient = create_recipient
      invoice = @client.invoice.create(recipientId: recipient.id, description: 'Integration Test Invoice Create')
      assert_not_nil(invoice)
      assert_not_nil(invoice.id)
      assert_equal('open', invoice.status)

      invoice_line = @client.invoice.create_line(invoiceId: invoice.id, lines: [{ unitAmount: { value: '2000', currency: 'USD' } }])
      assert_not_nil(invoice_line.lines)
      assert_not_nil(invoice_line.lines.first['id'])

      @client.invoice_payment.create(ids: [invoiceId: invoice.id])
      invoice_payments = @client.invoice_payment.search(invoiceIds: [invoice.id])
      assert_true(invoice_payments.count.positive?)

      findInvoice = @client.invoice.find(invoiceId: invoice.id)
      assert_equal('pending', findInvoice.status)
    end
  end

  def test_update
    with_vcr do
      recipient = create_recipient

      invoice = @client.invoice.create(recipientId: recipient.id, description: 'Integration Test Invoice Create')
      assert_not_nil(invoice)
      assert_not_nil(invoice.id)

      invoices = @client.invoice.search({})
      assert_true(invoices.count.positive?)

      invoice_line = @client.invoice.create_line(invoiceId: invoice.id, lines: [{ unitAmount: { value: '2000', currency: 'USD' } }])
      assert_not_nil(invoice_line.lines)
      assert_not_nil(invoice_line.lines.first['id'])

      invoice_payment = @client.invoice_payment.create(ids: [invoiceId: invoice.id])
      invoice_payments = @client.invoice_payment.search(invoiceIds: [invoice.id])
      assert_true(invoice_payments.count.positive?)
      assert_equal('2000.00', invoice_payments.first.amount['value'])

      response = @client.invoice_payment.update(paymentId: invoice_payment.paymentId, invoiceLineId: invoice_payment.invoicePayments.first['invoiceLineId'], amount: { value: '5000', currency: 'USD' })
      assert_true(response)
      invoice_payments = @client.invoice_payment.search(invoiceIds: [invoice.id])
      assert_true(invoice_payments.count.positive?)
      assert_equal('5000.00', invoice_payments.first.amount['value'])
    end
  end

  def test_delete
    with_vcr do
      recipient = create_recipient

      invoice = @client.invoice.create(recipientId: recipient.id, description: 'Integration Test Invoice Create')
      assert_not_nil(invoice)
      assert_not_nil(invoice.id)

      invoices = @client.invoice.search({})
      assert_true(invoices.count.positive?)

      invoice_line = @client.invoice.create_line(invoiceId: invoice.id, lines: [{ unitAmount: { value: '2000', currency: 'USD' } }])
      assert_not_nil(invoice_line.lines)
      assert_not_nil(invoice_line.lines.first['id'])

      invoice_payment = @client.invoice_payment.create(ids: [invoiceId: invoice.id])
      invoice_payments = @client.invoice_payment.search(invoiceIds: [invoice.id])
      assert_true(invoice_payments.count.positive?)

      response = @client.invoice_payment.delete(paymentId: invoice_payment.paymentId, invoiceLineIds: [invoice_payment.invoicePayments.first['invoiceLineId']])
      assert_true(response)
      invoice_payments = @client.invoice_payment.search(invoiceIds: [invoice.id])
      assert_true(invoice_payments.count.zero?)
    end
  end
end
