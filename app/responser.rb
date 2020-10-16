# frozen_string_literal: true

require 'json'

module Miniserver
  class Responser
    attr_reader :env, :req, :params

    NOT_ALLOWED_CODE = 405
    NOT_ACCEPTABLE_CODE = 406
    BAD_REQUEST_CODE = 400
    OK_CODE = 200

    NOT_ALLOWED_MESSAGE = 'HTTP Method not allowed'
    NOT_ACCEPTABLE_MESSAGE = 'Not Acceptable'
    BAD_REQUEST_MESSAGE = 'Bad Request'
    MISSING_PARAMS_MESSAGE = 'Error, missing or empty name or email'
    SUCCESSFUL_REQUEST_MESSAGE = 'Successful request'

    def initialize(env)
      @env = env
      @req = Rack::Request.new(@env)
      body = @req.body.read
      @params = body.empty? ? '' : JSON.parse(body)
    end

    def call
      status, message = get_status_and_message
      build_response(status: status, message: message)
    end
    
    private
    
    def get_status_and_message
      return [NOT_ALLOWED_CODE, NOT_ALLOWED_MESSAGE] unless req.post?

      if !acceptable
        [NOT_ACCEPTABLE_CODE, NOT_ACCEPTABLE_MESSAGE]
      elsif bad_request
        [BAD_REQUEST_CODE, BAD_REQUEST_MESSAGE]
      elsif missing_params
        [BAD_REQUEST_CODE, MISSING_PARAMS_MESSAGE]
      else
        [OK_CODE, SUCCESSFUL_REQUEST_MESSAGE]
      end
    end

    def build_response(status:, message:)
      [status, {'Content-Type' => 'application/json'},
        [{'message': message}.to_json]]
    end

    def bad_request
      env['CONTENT_TYPE'] != 'application/json' || params.empty?
    end

    def acceptable
      env['HTTP_ACCEPT'].include?('application/json')
    end

    def missing_params
      params['name'].nil? || params['email'].nil?
    end
  end
end
