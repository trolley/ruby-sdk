[Payment Rails Ruby SDK](../README.md) > [PaymentGateway](../classes/paymentgateway.md)

# Class: PaymentGateway

## Index

### Methods

* [create](paymentgateway.md#create)
* [find](paymentgateway.md#find)
* [remove](paymentgateway.md#remove)
* [search](paymentgateway.md#search)
* [update](paymentgateway.md#update)

---

## Methods

<a id="create"></a>

### create

► **create**(batchId: *`string`*, body: *`any`*): `Payment`

*Defined in [PaymentGateway.rb:55](https://github.com/PaymentRails/ruby-sdk/tree/master/lib/Gateway.rb#L55)*

Create a new payment in a batch

   client.payment.create('B-23wed2343', sourceAmount: '10.00', recipient: { id: 'R-123d8j89' })

**Parameters:**

| Param | Type | Description |
| ------ | ------ | ------ |
| batchId | `string`   |  Payment Rails payment id (e.g. "B-xx999bb") |
| body | `any`   |  Payment information |

**Returns:** `Payment`

---

<a id="find"></a>

### find

► **find**(paymentId: *`string`*): `Payment`

*Defined in [PaymentGateway.rb:34](https://github.com/PaymentRails/ruby-sdk/tree/master/lib/Gateway.rb#L34)*

Find a specific payment

    client.payment.find('B-12ed23rd1', 'P-123qwaer9')

**Parameters:**

| Param | Type | Description |
| ------ | ------ | ------ |
| paymentId | `string`   |  Payment Rails payment id (e.g. "P-aabccc") |

**Returns:** `Payment`

---

<a id="delete"></a>

### delete

► **delete**(paymentId: *`string`*, batchId: *`string`*): `boolean`

*Defined in [PaymentGateway.rb:90](https://github.com/PaymentRails/ruby-sdk/tree/master/lib/Gateway.rb#L90)*

Delete a given payment -- Note you can only delete non processed payments

    client.payment.delete('B-12ed23rd1', 'P-123qwaer9')

**Parameters:**

| Param | Type | Description |
| ------ | ------ | ------ |
| paymentId | `string`   |  Payment Rails payment id (e.g. "P-aabccc") |
| batchId | `string`   |  Payment Rails payment id (e.g. "B-xx999bb") |

**Returns:** `boolean`

---

<a id="search"></a>

### search

► **search**(batchId: *`string`*, page?: *`number`*, pageSize?: *`number`*, term?: *`string`*): `Payment`[]

*Defined in [PaymentGateway.rb:105](https://github.com/PaymentRails/ruby-sdk/tree/master/lib/Gateway.rb#L105)*

Search for payments in a given batch

**Parameters:**

| Param | Type | Default value | Description |
| ------ | ------ | ------ | ------ |
| batchId | `string`  | - |   Payment Rails payment id (e.g. "B-xx999bb") |
| page | `number`  | 1 |   Page number (1 based) |
| pageSize | `number`  | 10 |   Page size (0...1000) |
| term | `string`  | &quot;&quot; |   Any search terms to look for |

**Returns:** `Payment`[]

---

<a id="update"></a>

### update

► **update**(paymentId: *`string`*, batchId: *`string`*, body: *`any`*): `boolean`

*Defined in [PaymentGateway.rb:74](https://github.com/PaymentRails/ruby-sdk/tree/master/lib/Gateway.rb#L74)*

Update a given payment

    client.payment.update('B-123dc3', 'P-1dec23ea1', sourceAmount: '20.00')

**Parameters:**

| Param | Type | Description |
| ------ | ------ | ------ |
| paymentId | `string`   |  Payment Rails payment id (e.g. "P-aabccc") |
| batchId | `string`   |  Payment Rails payment id (e.g. "B-xx999bb") |
| body | `any`   |  Payment update information |

**Returns:** `boolean`

---