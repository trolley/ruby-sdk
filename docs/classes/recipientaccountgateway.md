[Payment Rails Ruby SDK](../README.md) > [RecipientAccountGateway](../classes/recipientaccountgateway.md)

# Class: RecipientAccountGateway

## Index

### Methods

* [findAll](recipientaccountgateway.md#findAll)
* [create](recipientaccountgateway.md#create)
* [find](recipientaccountgateway.md#find)
* [remove](recipientaccountgateway.md#remove)
* [update](recipientaccountgateway.md#update)

---

## Methods

<a id="all"></a>

### all

► **all**(recipientId: *`string`*): `List<RecipientAccount>`(recipientaccount.md)[]>

*Defined in [RecipientAccountGateway.rb:33](https://github.com/PaymentRails/ruby-sdk/tree/master/lib/RecipientAccountGateway.rb#L33)*

Fetch all of the accounts for a given Payment Rails recipient

    recipientAccount = client.recipient_account.all('R-1237fhe8j0')

**Parameters:**

| Param | Type | Description |
| ------ | ------ | ------ |
| recipientId | `string`   |  The Payment Rails recipient ID (e.g. R-xyzzy) |

**Returns:** `List<RecipientAccount>(recipientaccount.md)[]>

---

<a id="create"></a>

### create

► **create**(recipientId: *`string`*, body: *`RecipientAccount`*): `RecipientAccount`(recipientaccount.md)>

*Defined in [RecipientAccountGateway.rb:79](https://github.com/PaymentRails/ruby-sdk/tree/master/lib/RecipientAccountGateway.rb#L79)*

Create a new recipient account

    client.recipient_account.create('R-123rfn8no8n9m', type: 'bank-transfer', currency: 'EUR', country: 'DE', iban: 'DE89 3704 0044 0532 0130 00')

**Parameters:**

| Param | Type | Description |
| ------ | ------ | ------ |
| recipientId | `string`   |  The Payment Rails recipient ID (e.g. R-xyzzy) |
| body | `string`   |  Account information |

**Returns:** `RecipientAccount`(recipientaccount.md)>

---

<a id="find"></a>

### find

► **find**(recipientId: *`string`*, accountId: *`string`*): `RecipientAccount`(recipientaccount.md)>

*Defined in [RecipientAccountGateway.rb:52](https://github.com/PaymentRails/ruby-sdk/tree/master/lib/RecipientAccountGateway.rb#L52)*

Fetch a specific account for a given Payment Rails recipient

    recipientAccount = client.recipient_account.find('R-123rwdwddw3x', 'A-2345tyhgtr45')

**Parameters:**

| Param | Type | Description |
| ------ | ------ | ------ |
| recipientId | `string`   |  The Payment Rails recipient ID (e.g. R-xyzzy) |
| accountId | `string`   |  The Payment Rails account ID (e.g. A-xyzzy) |

**Returns:** `RecipientAccount`(recipientaccount.md)>

---

<a id="delete"></a>

### delete

► **delete**(recipientId: *`string`*, accountId: *`string`*): `boolean`

*Defined in [RecipientAccountGateway.rb:121](https://github.com/PaymentRails/ruby-sdk/tree/master/lib/RecipientAccountGateway.rb#L121)*

Delete the given recipient account. This will only return success, otherwise it will throw an exception (e.g. NotFound)

    recipientAccount = client.recipient_account.delete('R-123rwdwddw3x', 'A-2345tyhgtr45')

**Parameters:**

| Param | Type | Description |
| ------ | ------ | ------ |
| recipientId | `string`   |  The Payment Rails recipient ID (e.g. R-xyzzy) |
| accountId | `string`   |  The Payment Rails account ID (e.g. A-xyzzy) |

**Returns:** `boolean`

---

<a id="update"></a>

### update

► **update**(recipientId: *`string`*, accountId: *`string`*, body: *`RecipientAccount`*): `RecipientAccount`(recipientaccount.md)>

*Defined in [RecipientAccountGateway.rb:102](https://github.com/PaymentRails/ruby-sdk/tree/master/lib/RecipientAccountGateway.rb#L102)*

Update a recipient account. Note: Updating an account will create a new account ID if it contains any property that isn't just "primary"

   recipientAccount = client.recipient_account.update('R-123rwdwddw3x', 'A-2345tyhgtr45', primaery: false)

**Parameters:**

| Param | Type | Description |
| ------ | ------ | ------ |
| recipientId | `string`   |  The Payment Rails recipient ID (e.g. R-xyzzy) |
| accountId | `string`   |  The Payment Rails account ID (e.g. A-xyzzy) |
| body | `any`   |  Account information |

**Returns:** `RecipientAccount`(recipientaccount.md)>

---