[Payment Rails Ruby SDK](../README.md) > [RecipientGateway](../classes/RecipientGateway.md)

# Class: RecipientGateway

## Index

### Methods

* [create](RecipientGateway.md#create)
* [find](RecipientGateway.md#find)
* [remove](RecipientGateway.md#remove)
* [search](RecipientGateway.md#search)
* [update](RecipientGateway.md#update)

---

## Methods

<a id="create"></a>

### create

► **create**(body: *[Recipient](../types/recipient.md)*): `Recipient`

*Defined in [RecipientGateway.rb:82](https://github.com/PaymentRails/ruby-sdk/tree/master/lib/RecipientGateway.rb#L82)*

Create a given recipient

    recipient = client.recipient.create(
      type: 'individual',
      firstName: 'Tom',
      lastName: 'Jones',
      email: 'tomjones@example.com'
    )

**Parameters:**

| Param | Type | Description |
| ------ | ------ | ------ |
| body | [Recipient](../types/recipient.md)   |  The recipient information to create |

**Returns:** `Recipient`

---

<a id="find"></a>

### find

► **find**(recipientId: *`string`*): `Recipient`

*Defined in [RecipientGateway.rb:58](https://github.com/PaymentRails/ruby-sdk/tree/master/lib/RecipientGateway.rb#L58)*

Find a specific recipient by their Payment Rails recipient ID

    recipient = client.recipient.find('R-12n3frv78')

**Parameters:**

| Param | Type | Description |
| ------ | ------ | ------ |
| recipientId | `string`   |  The Payment Rails recipient ID (e.g. R-xyzzy) |

**Returns:** `Recipient`

---

<a id="delete"></a>

### delete

► **delete**(recipientId: *`string`*): `boolean`

*Defined in [RecipientGateway.rb:115](https://github.com/PaymentRails/ruby-sdk/tree/master/lib/RecipientGateway.rb#L115)*

Delete the given recipient.

    recipient = client.recipient.delete('R-12n3frv78');

**Parameters:**

| Param | Type | Description |
| ------ | ------ | ------ |
| recipientId | `string`   |  The Payment Rails recipient ID (e.g. R-xyzzy) |

**Returns:** `boolean`

---

<a id="search"></a>

### search

► **search**(page: *`number`*, pageSize: *`number`*, term: *`string`*): `Recipient`[]

*Defined in [RecipientGateway.rb:123](https://github.com/PaymentRails/ruby-sdk/tree/master/lib/RecipientGateway.rb#L123)*

**Parameters:**

| Param | Type | Description |
| ------ | ------ | ------ |
| page | `number`   |  - |
| pageSize | `number`   |  - |
| term | `string`   |  - |

**Returns:** `Recipient`[]

---

<a id="update"></a>

### update

► **update**(body: *[Recipient](../types/recipient.md)*): `boolean`

*Defined in [RecipientGateway.rb:100](https://github.com/PaymentRails/ruby-sdk/tree/master/lib/RecipientGateway.rb#L100)*

Update the given recipient

    response = client.recipient.update('R-1a234rf4', firstName: 'Bob')

**Parameters:**

| Param | Type | Description |
| ------ | ------ | ------ |
| body | [Recipient](../types/recipient.md)   |  the changes to make to the recipient |

**Returns:** `boolean`

---