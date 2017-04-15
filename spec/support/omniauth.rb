def set_omniauth_facebook(hash = {})
  mock_value = {
      uid: '10000',
      info: {
        email: 'test@example.com'
      },
      credentials: {
        token: 'mock_token'
      },
      extra: {
        raw_info: {
          name: 'ryuzee'
        }
      }
    }.merge(hash)
  OmniAuth.config.add_mock(:facebook, mock_value)
end

def set_omniauth_twitter(hash = {})
  mock_value = {
      uid: '20000',
      info: {
        name: 'john',
        nickname: 'john',
        description: 'This is John'
      },
      credentials: {
        token: 'mock_token'
      },
      extra: {
        raw_info: {
          name: 'john'
        }
      }
    }.merge(hash)
  OmniAuth.config.add_mock(:twitter, mock_value)
end
