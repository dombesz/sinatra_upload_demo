helpers do
  #shamelessly stolen from rails 
  JS_ESCAPE_MAP = {
    '\\'    => '\\\\',
    '</'    => '<\/',
    "\r\n"  => '\n',
    "\n"    => '\n',
    "\r"    => '\n',
    '"'     => '\\"',
    "'"     => "\\'" }

  # Escape carrier returns and single and double quotes for JavaScript segments.
  # Also available through the alias j(). This is particularly helpful in JavaScript responses, like:
  #
  #   $('some_element').replaceWith('<%=j render 'some/element_template' %>');
  def escape_javascript(javascript)
    if javascript
      result = javascript.gsub(/(\\|<\/|\r\n|[\n\r"'])/) {|match| JS_ESCAPE_MAP[match] }
      result
    else
      ''
    end
  end

  alias_method :j, :escape_javascript
end