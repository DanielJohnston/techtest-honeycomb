# techtest-honeycomb
Tech test from Honeycomb TV - apply rule-based discounts to orders

## Specification

_[Taken from the Honeycomb TV test repo](https://github.com/honeycomb-tv-recruitment/makers-test)_

> We have a system that delivers advertising materials to broadcasters.
>
> Advertising Material is uniquely identified by a 'Clock' number e.g.
>
> * `WNP/SWCL001/010`
> * `ZDW/EOWW005/010`
>
> Our sales team have some new promotions they want to offer so
> we need to introduce a mechanism for applying Discounts to orders.
>
> Promotions like this can and will change over time so we need the solution to be flexible.
>
> #### Broadcasters
>
> These are the Broadcasters we deliver to
>
> * Viacom
> * Disney
> * Discovery
> * ITV
> * Channel 4
> * Bike Channel
> * Horse and Country
>
>
> #### Delivery Products
>
> * Standard Delivery: $10
> * Express Delivery: $20
>
> #### Discounts
>
> * Send 2 or more materials via express delivery and the price for express delivery drops to $15
> * Spend over $30 to get 10% off
>
> #### What we want from you
>
> Provide a means of defining and applying various discounts to the cost of delivering material to broadcasters.
>
> We don't need any UI for this, we just need you to show us how it would work through its API.
>
> ### Examples
>
> Based on the both Discounts applied, the following examples should be valid:
>
> * send `WNP/SWCL001/010` to Disney, Discovery, Viacom via Standard Delivery and Horse and Country via Express Delivery
>     based on the defined Discounts the total should be $45.00
>
> * send `ZDW/EOWW005/010` to Disney, Discovery, Viacom via Express Delivery
>      based on the defined Discounts the total should be $40.50

## Installation and running

This assumes you're installing using a command line on macOS or Linux, or the bash shell in Windows Subsystem for Linux on a Windows 10 Pro edition computer, and that you already have a recent version of Ruby installed.

1. Clone the repo to your local machine, using e.g. `git clone https://github.com/honeycomb-tv-recruitment/makers-test.git`
2. `cd` into the root of the folder structure
3. `gem install bundler` if you don't already have Bundler installed
4. `bundle install` to install required gems and check Ruby compatibility
5. `rspec` to run tests

Running instructions will be added once sufficient running functionality is available.

## Technologies

I'm planning on using the following tools to meet the specification:

* *Ruby* to write the solution code
* *Bundler* to define the required gems and Ruby version, dependent on purpose
* *RSpec* to define the feature and unit tests that drive development

The API functionality is something of an assumption. The spec asks to `show us how it would work through its API`. I've interpreted this as a request for an API in the sense that gems have an API: a set of classes, objects and methods that can be addressed from IRB, or Pry, or by using `require` to pull the solution into another codebase. If necessary, this could be replaced with an HTTP API using Sinatra, but that didn't seem to be the intention.

Technology that will *not* be used:

* *Capybara* - This provides web-driven feature testing. However, we're not creating a web interface, so it would require unnecessary extra functionality to be added on top of the spec in order to work
* *PostgreSQL or SQLite* - The spec doesn't request persistence of orders between or across sessions
* *Rails or Sinatra* - This would make sense in the context of a larger application, especially with web or HTTP API functionality, but is too much for the current specification

## Development approach

The spec lends itself to a TDD approach, with a structure that develops following OOP principles. Specifically, the two examples in the spec provide useful feature tests, which can drive the creation of unit tests and thence the actual code through a red-green-refactor cycle.

It's unlikely that git branches will be useful in this project, as there aren't multiple features being developed in parallel or by different coders, and there's no requirement to maintain a 'blessed' production version.

It's not helpful to assume the full structure at the start, so the initial tests and development will build out from a small number of classes, extracting further classes as they become justified by the complexity of the code. This will entail rewriting feature and unit tests each time a class is extracted. A proposed task list follows:

- [x] Write up approach and structure in README
- [x] Set up the Gemfile and RSpec
- [x] Write failing feature tests matching the specified examples
- [ ] Write and pass unit tests for order creation, material creation, broadcaster creation
- [ ] Write and pass unit tests for adding deliveries to orders
- [ ] Write and pass unit tests for order total
- [ ] Write and pass unit tests for applying discounts
- [ ] Pass the feature tests
- [ ] Extract out delivery lists, discounts, discount lists, delivery products

## Structure

The spec is essentially for an ecommerce system, where an order has:

* A single (for now) item of advertising material
* One or more recipients each of which has a specified delivery method. Each recipient and delivery method equates to an order line
* A subtotal
* A selection of zero or more rules-based discounts, which (for now) are applied per-order
* A total derived from the subtotal and discounts

Structurally, this gives us the following objects and interface methods as a likely outcome of development:

* Material - the item of advertising material, defined by a unique 'Clock' number
     * self#new (clock)
     * #clock returns the unique clock number of the Material object
* Broadcaster - a recipient of advertising material, e.g. Viacom or Disney
     * self#new (name)
     * #name
* DeliveryProduct - a type of delivery and standard price for that type
     * self#new (name, price)
     * #name
     * #price
* DeliveryList - a list of all the Broadcaster / Deliveryproduct order lines for an order
     * self#new (broadcaster, delivery_product)
* Discount - a discount rule applied to the contents of an order to calculate the order total
* DiscountList - a list of all the discounts applied to an order
* Order - a single order for delivery of an item of advertising material to one or more recipients
     * self#new (material)
     * #clock
     * #add_delivery (broadcaster, delivery_product) - this could factor out to its own class
     * #delivery_list
     * #subtotal
     * #add_discount (discount)
     * #discount_list
     * #total

The add_delivery and add_discount methods are reminiscent of the builder pattern for adding features to an object.

### Discounts

Discounts are a structural special case. Each discount is a rule, invoked on the combination of deliveries, the subtotal, _and the impacts of other discounts_ when calculating the order total.

The interplay of discounts is evident in the second example of the spec. The subtotal for 3 express deliveries is 3x20 = $60. The first discount rule kicks in for 2 or more express deliveries, discounting the subtotal by 3x5 = $15, leaving $45. Only then is the second discount applied, discounting the remainder $45 by 10%, leaving $40.50.

The order of applying rules is also critical to get right. Applying the discounts in reverse order to the second example gives 60 - (10% of subtotal = $6) - ($5 discount on 3 items = $15) = $39, a completely different order total.

It's difficult to be certain of future requirements for interaction between different discounts. However, a reasonable assumption is that the discount rules should run in a pre-defined order, regardless of which is added to the order first, with each rule a de facto order line that passes along an updated subtotal to the next. This allows a hierarchy of rules to be established, guaranteeing the same result each time.

In terms of how to define, store and add rules, the strategy pattern is a potential approach that might work. Rather than storing rules in a custom format and interpreting them each time, it makes sense to hardcode the rules until such time as a more user-customisable solution is required. However, how #add_discount would work to enable running of a rule against an order subtotal requires more thought.
