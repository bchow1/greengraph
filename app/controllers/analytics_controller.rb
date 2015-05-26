class AnalyticsController < ApplicationController
  def index
      #get all gas readings for each class -- MOVE THESE TO MODEL
      comgasboro = Reading.where('business_class = ? and gas_billed IS NOT NULL and city_code = ?', "Commercial", "PRINCETON BORO")
      comgastwp = Reading.where('business_class = ? and gas_billed IS NOT NULL and city_code = ?', "Commercial", "PRINCETON TWP")
      indgasboro = Reading.where('business_class = ? and gas_billed IS NOT NULL and city_code = ?', "Industrial", "PRINCETON BORO")
      indgastwp = Reading.where('business_class = ? and gas_billed IS NOT NULL and city_code = ?', "Industrial", "PRINCETON TWP")
      resgasboro = Reading.where('business_class = ? and gas_billed IS NOT NULL and city_code = ?', "Residential", "PRINCETON BORO")
      resgastwp = Reading.where('business_class = ? and gas_billed IS NOT NULL and city_code = ?', "Residential", "PRINCETON TWP")
      @commercialgas = comgasboro.pluck(:gas_billed).sum + comgastwp.pluck(:gas_billed).sum
      @industrialgas = indgasboro.pluck(:gas_billed).sum + indgastwp.pluck(:gas_billed).sum
      @residentialgas = resgasboro.pluck(:gas_billed).sum + resgastwp.pluck(:gas_billed).sum
      #break down gas readings per reading per class -- MOVE THESE TO MODEL
      comgas2009 = comgasboro.where(read_date: DateTime.new(2009)..(DateTime.new(2010) - 1.month))
      indgas2009 = indgasboro.where(read_date: DateTime.new(2009)..(DateTime.new(2010) - 1.month))
      resgas2009 = resgasboro.where(read_date: DateTime.new(2009)..(DateTime.new(2010) - 1.month))
      @commercialgasbreakread = comgas2009.pluck(:read_date).map{|readdate| readdate.strftime("%B, %Y").gsub(/,/, '')}
      @commercialgasbreakbilled = comgas2009.pluck(:gas_billed)
      @industrialgasbreakread = indgas2009.pluck(:read_date).map{|readdate| readdate.strftime("%B, %Y").gsub(/,/, '')}
      @industrialgasbreakbilled = indgas2009.pluck(:gas_billed)
      @residentialgasbreakread = resgas2009.pluck(:read_date).map{|readdate| readdate.strftime("%B, %Y").gsub(/,/, '')}
      @residentialgasbreakbilled = resgas2009.pluck(:gas_billed)
  end
end
