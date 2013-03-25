# Semaphore-dashing

Simple [Dashing](https://github.com/Shopify/dashing) widget to display the status of the latest build for a repository on [Semaphore CI](https://semaphoreapp.com).

## Installation

Clone this repo (`git clone https://github.com/rastasheep/semaphore-dashing.git`) and then copy files to your folder with Dashing instance. (`mv -r semaphore-dashing/ sweet_dashboard_project/`)
And you are done.

The Semaphore job expects `config/semaphore.yml` to look like:

```yaml
auth_token: my_org_auth_token
repositories:
  # data-id: project/branch
  base-app: base-app/master
  testapp-mongodb: testapp-mongodb/mongoid3
  # or
  # data-id: project
  testapp-sphinx: testapp-sphinx
```

If you don't specify a branch, the last build on the project will be displayed, on any branch. Otherwise the last build for that branch will be displayed.

## Usage

To include the widgets in a dashboard, add the following snippet for each project to the dashboards layout file:

```html
<li data-row="1" data-col="1" data-sizex="1" data-sizey="1">
  <div data-id="base-app" data-view="Semaphore" data-unordered="true" data-title="Base-app"></div>
</li>
```

data-id - defined in `config/semaphore.yml` and represents your project
data-title - title that you want to see on dashboard for that project

## Screenshots

![semaphore dashing usage](https://dl.dropbox.com/u/5802579/semaphore-dashing.png '')

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Semaphore-dashing is released under the MIT License.
Developed by [rastasheep](https://github.com/rastasheep).
