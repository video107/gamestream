# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( jquery.carousel-3d.js jquery.resize.js jquery.waitforimages.js main.js modernizr-2.8.3.min.js jquery.carousel-3d.default.css vendor.css theme_black_red.css )
