# API V1 Base Controller
# All controllers must inherite from this class
class Api::V1::ApiController < ApplicationController
  # include DeviseTokenAuth::Concerns::SetUserByToken

  # before_action :authenticate_user!

  VERSION = 'Version 1'.freeze
  end
