# MyBlog

## Installation

```cmd
docker-compose build
docker-compose run web rake db:create
docker-compose up
```

[Quickstart: Compose and Rails](https://docs.docker.com/compose/rails)

## Credentials

```cmd
docker-compose run web rails credentials:edit

heroku config:set RAILS_MASTER_KEY=`cat config/master.key`
```


## Sitemap

```cmd
heroku run rails sitemap:refresh
```

## Gems

- [rouge](https://github.com/rouge-ruby/rouge)
- [redcarpet](https://github.com/vmg/redcarpet)
- [rspec-rails](https://github.com/rspec/rspec-rails)
- [hamlit](https://github.com/k0kubun/hamlit)
- [devise](https://github.com/heartcombo/devise)
- [acts-as-taggable-on](https://github.com/mbleigh/acts-as-taggable-on)
- [kaminari](https://github.com/kaminari/kaminari)
- [carrierwave](https://github.com/search?q=carrierwave)
- [rmagic](https://github.com/rmagick/rmagick)
- [fog](https://github.com/fog/fog)
- [active_link_to](https://github.com/comfy/active_link_to)
- [ransack](https://github.com/activerecord-hackery/ransack)
- [whenever](https://github.com/javan/whenever)
- [heroku-buildpack-nginx](https://github.com/heroku/heroku-buildpack-nginx/)

### SEO

- [google-api-client](https://github.com/googleapis/google-api-ruby-client)
- [sitemap_generator](https://github.com/adamsalter/sitemap_generator)
- [meta-tags](https://github.com/kpumuk/meta-tags)
- [roboto](https://github.com/LaunchAcademy/roboto)

### Assets

- [bootstrap-rubygem](https://github.com/twbs/bootstrap-rubygem)
- [bootstrap4-tagsinput](https://github.com/Nodws/bootstrap4-tagsinput)
- [hover-rails](https://github.com/Leyka/hover-rails)
- [jquery-ui-rails](https://github.com/jquery-ui-rails/jquery-ui-rails)
- [social-share-button](https://github.com/huacnlee/social-share-button)
- [font-awesome-sass](https://fontawesome.com/)
- [devicon](https://devicon.dev/)