require 'omniauth'

require 'omni_auth/multi_provider/handler'
require 'omni_auth/multi_provider/version'

module OmniAuth
  module MultiProvider
    def self.register(builder, options={}, &dynamic_options_generator)
      provider_name = options.fetch(:provider_name, nil)
      path_prefix = options.fetch(:path_prefix, ::OmniAuth.config.path_prefix)
      identity_provider_id_regex = options.fetch(:identity_provider_id_regex, nil)

      options.delete_if {|key,v| [:provider_name, :identity_provider_id_regex].include?(key) }

      handler = OmniAuth::MultiProvider::Handler.new(:path_prefix => path_prefix,
                                                     :identity_provider_id_regex => identity_provider_id_regex,
                                                     &dynamic_options_generator)

      builder.provider(provider_name, options.merge(handler.provider_options))
    end
  end
end
