[Payment Rails Ruby SDK](../README.md) > [BatchGateway](../classes/BatchGateway.md)

# Class: BatchGateway

Gateway class for batches
*__class__*: BatchGateway

## Index

### Methods

* [create](BatchGateway.md#create)
* [find](BatchGateway.md#find)
* [generate_quote](BatchGateway.md#generate_quote)
* [delete](BatchGateway.md#delete)
* [search](BatchGateway.md#search)
* [start_processing](BatchGateway.md#start_processing)
* [summary](BatchGateway.md#summary)
* [update](BatchGateway.md#update)

---

## Methods

<a id="create"></a>

### create

► **create**(body: *`Batch`*): `Batch`

*Defined in [BatchGateway.rb:18](https://github.com/PaymentRails/ruby-sdk/blob/dev/lib/BatchGateway.rb#L18)*

Creates a batch with optional payments. This is the interface that is provide by the [Create Batch](http://docs.paymentrails.com/api/#create-a-batch) API

    client.batch.create(
      sourceCurrency: 'USD', description: 'Integration Test Payments', payments: [
        { targetAmount: '10.00', targetCurrency: 'EUR', recipient: { id: 'R-12agg5' } },
        { sourceAmount: '10.00', recipient: { id: 'R-w1ekf493g5' } }
      ]
    )

**Parameters:**

| Param | Type | Description |
| ------ | ------ | ------ |
| body | `Batch`   |  - |

**Returns:** `Batch`

---

<a id="find"></a>

### find

► **find**(batchId: *`string`*): `Batch`

*Defined in [BatchGateway.rb:8](https://github.com/PaymentRails/ruby-sdk/blob/dev/lib/BatchGateway.rb#L8)*

Retrieves a batch based on the batch id

    client.batch.find('B-bkefew9j11')

**Parameters:**

| Param | Type | Description |
| ------ | ------ | ------ |
| batchId | `string`   |  Payment Rails batch id (e.g. "B-xx999bb") |

**Returns:** `Batch`

---

<a id="generate_quote"></a>

### generate_quote

► **generate_quote**(batchId: *`string`*): `Batch`

*Defined in [BatchGateway.rb:33](https://github.com/PaymentRails/ruby-sdk/blob/dev/lib/BatchGateway.rb#L33)*

Generate a FX quote for this batch

**Parameters:**

| Param | Type | Description |
| ------ | ------ | ------ |
| batchId | `string`   |  Payment Rails payment id (e.g. "B-xx999bb") |

**Returns:** `Batch`

---

<a id="delete"></a>

### delete

► **delete**(batchId: *`string`*): `Boolean`

*Defined in [BatchGateway.rb:28](https://github.com/PaymentRails/ruby-sdk/blob/dev/lib/BatchGateway.rb#L28)*

Delete the given batch

    client.batch.delete('B-1a2b3c4d5e6f')

**Parameters:**

| Param | Type | Description |
| ------ | ------ | ------ |
| batchId | `string`   |  Payment Rails batch (e.g. "B-xx999bb") |

**Returns:** `Boolean`

---

<a id="search"></a>

### search

► **search**(page?: *`number`*, pageSize?: *`number`*, term?: *`string`*): `Batch`[]

*Defined in [BatchGateway.rb:43](https://github.com/PaymentRails/ruby-sdk/blob/dev/lib/BatchGateway.rb#L43)*

Search for a batch matching the given term

**Parameters:**

| Param | Type | Default value | Description |
| ------ | ------ | ------ | ------ |
| page | `number`  | 1 |   - |
| pageSize | `number`  | 10 |   - |
| term | `string`  | &quot;&quot; |   string search term |

**Returns:** `Batch`[]

---

<a id="start_processing"></a>

### start_processing

► **start_processing**(batchId: *`string`*): `Batch`

*Defined in [BatchGateway.rb:38](https://github.com/PaymentRails/ruby-sdk/blob/dev/lib/BatchGateway.rb#L38)*

Start processing this batch

**Parameters:**

| Param | Type | Description |
| ------ | ------ | ------ |
| batchId | `string`   |  Payment Rails batch id (e.g. "B-xx999bb") |

**Returns:** `Batch`

---

<a id="summary"></a>

### summary

► **summary**(batchId: *`string`*): `String`

*Defined in [BatchGateway.rb:60](https://github.com/PaymentRails/ruby-sdk/blob/dev/lib/BatchGateway.rb#L60)*

Get a transaction totaled summary for this batch

**Parameters:**

| Param | Type | Description |
| ------ | ------ | ------ |
| batchId | `string`   |  Payment Rails payment id (e.g. "B-xx999bb") |

**Returns:** `String`

---

<a id="update"></a>

### update

► **update**(batchId: *`string`*, body: *`Batch`*): `Boolean`

*Defined in [BatchGateway.rb:23](https://github.com/PaymentRails/ruby-sdk/blob/dev/lib/BatchGateway.rb#L23)*

Update a batch

**Parameters:**

| Param | Type | Description |
| ------ | ------ | ------ |
| batchId | `string`   |  Payment Rails batch id (e.g. "B-xx999bb") |
| body | `Batch`   |  - |

**Returns:** `Boolean`

---
