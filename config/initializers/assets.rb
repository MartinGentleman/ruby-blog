# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( signed_in.js )
Rails.application.config.assets.precompile += %w( dynamic_menu.js )
Rails.application.config.assets.precompile += %w( media_manager.js )
Rails.application.config.assets.precompile += %w( signed_in.css )
Rails.application.config.assets.precompile += %w( web_page_editor.js )
Rails.application.config.assets.precompile += %w( syntax_highlighter.js )
Rails.application.config.assets.precompile += %w( analytics_api_v3_auth.js )
Rails.application.config.assets.precompile += %w( analytics_api_v3.js )
Rails.application.config.assets.precompile += %w( datetimepicker.js )
Rails.application.config.assets.precompile += %w( datetimepicker.css )
Rails.application.config.assets.precompile += %w( translations_en.js )
Rails.application.config.assets.precompile += %w( translations_cs.js )