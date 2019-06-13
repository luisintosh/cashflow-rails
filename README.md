# Cashflow Ruby

## Description
Cashflow Ruby is a web application that allows you to manage your sales and inventory on website.Update your stock information, make purchases and view sales data from anywhere whether in the office, at home, in the warehouse, or on the go. All you need to access this a device with internet connection.

### **Features**

-   Manage customers, supplier, users
-   Manage item with category
-   Manage multiple warehouse
-   Manage orders, invoices and payments
-   Manage bank accounts and transactions
-   Manage sales, purchases, expense and income reports


<p>
<image src=https://i.imgur.com/spQl85b.png style="display: inline; float: left; margin: 0 0;" width="45%"/>
<image src=https://i.imgur.com/SFlaLtK.png style="display: inline; float: left; margin: 0 0;" width="45%"/>
<image src=https://i.imgur.com/KSfA1lE.png style="display: inline; float: left; margin: 0 0;" width="45%"/>
<image src=https://i.imgur.com/xaDFk7B.png style="display: inline; float: left; margin: 0 0;" width="45%"/>
</p>

Contact: [luis@tequilapps.com](mailto:luis@tequilapps.com)

## Install

### Clone the repository

```shell
git clone git@github.com:luisintosh/cashflow-rails.git
cd cashflow-rails
```

### Check your Ruby version

```shell
ruby -v
```

The ouput should start with something like `ruby 2.5.1`

If not, install the right ruby version using [rbenv](https://github.com/rbenv/rbenv) (it could take a while):

```shell
rbenv install 2.5.1
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler) and [Yarn](https://github.com/yarnpkg/yarn):

```shell
bundle
```

### Initialize the database

```shell
rails db:create db:migrate db:seed
```

### Add heroku remotes

Using [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli):

```shell
heroku git:remote -a project
heroku git:remote --remote heroku-staging -a project-staging
```

## Serve

```shell
rails s
```

## Deploy

### With Heroku pipeline (recommended)

Push to Heroku staging remote:

```shell
git push heroku-staging
```

Go to the Heroku Dashboard and [promote the app to production](https://devcenter.heroku.com/articles/pipelines) or use Heroku CLI:

```shell
heroku pipelines:promote -a project-staging
```

### Directly to production (not recommended)

Push to Heroku production remote:

```shell
git push heroku
```
