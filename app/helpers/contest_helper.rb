module ContestHelper
  
  BIRTH_YEAR_BOUND_LOWER = 2007
  BIRTH_YEAR_BOUND_UPPER = 2020
  
  BG_MONTH_NAMES = Array.[]('Януари', 'Февруари', 'Март', 'Април', 'Май', 
        'Юни', 'Юли', 'Август', 'Септември', 'Октомври', 'Ноември', 'Декември')
  
  def date_input(set_to_date, obj_name, attr_name)
    output = ''
    
    # DAY
    output += sprintf("<select name=\"%s[%s_day]\" >\n", obj_name, attr_name) 
    1.upto(31) do |i|
      output += "<option value=\"#{i}\"" + (set_to_date.day == i ? 'selected' : '') + "/>#{i}\n"
    end
    output += "</select>\n"
    
    # MONTH
    output += sprintf("<select name=\"%s[%s_month]\" >\n", obj_name, attr_name) 
    1.upto(12) do |i|
      output += "<option value=\"#{i}\"" + (set_to_date.month == i ? 'selected' : '') + "/>#{BG_MONTH_NAMES[i-1]}\n"
    end
    output += "</select>\n"
    
    # YEAR
    output += sprintf("<select name=\"%s[%s_year]\" >\n", obj_name, attr_name) 
    BIRTH_YEAR_BOUND_UPPER.downto(BIRTH_YEAR_BOUND_LOWER) do |i|
      output += "<option value=\"#{i}\"" + (set_to_date.year == i ? 'selected' : '') + "/>#{i}\n"
    end
    output += "</select>\n"
    
    return output
  end
  
end
