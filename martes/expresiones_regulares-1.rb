#\d es para digitos, {#} es el número de repeticiones de \d, [-] es guión textual, \b es para que no sea true con menos números en cada serie
VALID_NUMBER_REGEX = /\b\d{4}[-]\d{3}[-]\d{3}\b/

def has_account_number?(string)
  true if string =~ VALID_NUMBER_REGEX
end

def account_number(string)
  string[VALID_NUMBER_REGEX]
end

def account_number_array(string)
  # http://ruby-doc.org/core-1.9.3/String.html#method-i-scan
  string.scan(VALID_NUMBER_REGEX)
end


def replace_account_number(string)
  # Reemplaza todos los dígitos excepto los ultimos 3 (.)
  string[VALID_NUMBER_REGEX].gsub(/\d(?=...)/, 'x') if string =~ VALID_NUMBER_REGEX
end

def format_account_number(string)
  # Sólo numeros de 10 digitos, para eso es \b
  if string =~ /(\b\d{10}\b)/
    string[/(\b\d{10}\b)/].insert(7, '-').insert(4, '-')
  elsif string =~ /\b\d{4}[.]\d{3}[.]\d{3}\b/
    string[/\b\d{4}[.]\d{3}[.]\d{3}\b/].gsub(/[.]/, '-')
  elsif string =~ VALID_NUMBER_REGEX
    string[VALID_NUMBER_REGEX]
  end  
end

# Pruebas
p has_account_number?("El Cliente con el número de cuenta 1234-123-123 se encuentra en proceso de revisión de sus documentos") == true
p has_account_number?("El Cliente con el número de cuenta 1234-123-12 se encuentra en proceso de revisión de sus documentos") == nil
p has_account_number?("El Cliente con el número de cuenta 1234-123123 se encuentra en proceso de revisión de sus documentos") == nil
p has_account_number?("El Cliente con el número de cuenta 1234-12333-123 se encuentra en proceso de revisión de sus documentos") == nil

p account_number("El Cliente con el número de cuenta 1234-123-123 se encuentra en proceso de revisión de sus documentos") == "1234-123-123"
p account_number("El Cliente con el número de cuenta 1234-1233-123 se encuentra en proceso de revisión de sus documentos") == nil
p account_number("El Cliente con el número de cuenta 1234-13-123 se encuentra en proceso de revisión de sus documentos") == nil
p account_number("El Cliente con el número de cuenta 1114-567-324 se encuentra en proceso de revisión de sus documentos") == "1114-567-324"

p account_number_array("El Cliente con el número de cuenta 1234-123-123 se encuentra en proceso de revisión de sus documentos") == ["1234-123-123"]
p account_number_array("Hay que transferir los fondos de la cuenta 1234-123-123 a la cuenta 4321-321-311") == ["1234-123-123", "4321-321-311"]
p account_number_array("Hay que transferir los fondos de la cuenta 1234-123-123 a la cuenta 4321-3231-311") == ["1234-123-123"]
p account_number_array("Hay que transferir los fondos de la cuenta 1234-1233-123 a la cuenta 4321-321-311") == ["4321-321-311"]

p replace_account_number("El Cliente con número de cuenta 1234-123-123 se encuentra en proceso de revisión de sus documentos") == "xxxx-xxx-123"
p replace_account_number("El Cliente con el número de cuenta 124-12-123 se encuentra en proceso de revisión de sus documentos") == nil
p replace_account_number("El Cliente con el número de cuenta 1234-13323-123 se encuentra en proceso de revisión de sus documentos") == nil
p replace_account_number("El Cliente con el número de cuenta 3279-278-346 se encuentra en proceso de revisión de sus documentos") == "xxxx-xxx-346"

p format_account_number("El Cliente con el número de cuenta 1234123123 se encuentra en proceso de revisión de sus documentos") == "1234-123-123"
p format_account_number("El Cliente con el número de cuenta 1234.123.123 se encuentra en proceso de revisión de sus documentos") == "1234-123-123"
p format_account_number("El Cliente con el número de cuenta 12123123 se encuentra en proceso de revisión de sus documentos") == nil
p format_account_number("El Cliente con el número de cuenta 3245-327-564 se encuentra en proceso de revisión de sus documentos") == "3245-327-564"


