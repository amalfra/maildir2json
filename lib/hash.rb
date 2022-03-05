# frozen_string_literal: true

# This helper function will convert all hash values into UTF8
class Hash
  def to_utf8
    Hash[
      collect do |k, v|
        if v.respond_to?(:to_utf8)
          [k, v.to_utf8]
        elsif v.respond_to?(:encoding) && v.dup.respond_to?(:encode)
          [k, v.dup.encode('UTF-8', invalid: :replace, undef: :replace, replace: '?')]
        else
          [k, v]
        end
      end
    ]
  end
end
