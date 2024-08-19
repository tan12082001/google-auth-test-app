Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, ENV['649367985748-qedkf6kg4dle23m65sq1h6jmdvvstd4s.apps.googleusercontent.com'], ENV['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'], {
        scope: 'email,profile',
        prompt: 'select_account',
        image_aspect_ration: 'square',
        image_size: 50,
        access_type: 'offline'    
    }
end