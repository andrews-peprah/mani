module Mani
  module Provider

    # Verifies the user's service provider
    # if service provider is not found it will send false back
    def get(telephone)
      if telephone[0] != "0"
        telephone = "0#{telephone}"
      end

      regexp_mtn = Regexp.new("((024|054|055){1}[0-9]{7}){1}$")
      regexp_tigo = Regexp.new("((027|057){1}[0-9]{7}){1}$")
      regexp_vodafone = Regexp.new("((020|050){1}[0-9]{7}){1}$")
      regexp_airtel = Regexp.new("((026|056){1}[0-9]{7}){1}$")
      case telephone
        when regexp_tigo
          return "tigo"
        when regexp_mtn
          return "mtn"
        when regexp_vodafone
          return "vodafone"
        when regexp_airtel
          return "airtel"
      end

      return false
    end


    module_function :get
  end
end
