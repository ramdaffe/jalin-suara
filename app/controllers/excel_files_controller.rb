require 'roo'

class ExcelFilesController < ApplicationController
  
  # POST /admin/excel_files
  # Importing data from excel file
  def create
    @excel_file = ExcelFile.new(params[:excel_file])
    respond_to do |format|
      if @excel_file.save
        redirect_path = activities_path
        file = Excel.new(@excel_file.document.path)
        2.upto(file.last_row) do |line|
          province_name = file.cell(line, 'B')
          district_name = file.cell(line, 'D')
          subdistrict_name = file.cell(line, 'F')

          province = Province.find_by_name(province_name)
          if province == nil
            province = Province.create(:name => province_name)
          end

          district = District.find_by_name(district_name)
          if district == nil
            district = District.create(:name => district_name, :province_id => province.id)
          end

          subdistrict = Subdistrict.find_by_name(subdistrict_name)
          if subdistrict == nil
            subdistrict = Subdistrict.create(:name => subdistrict_name, :district_id => district.id)
          end

          # Preparting activity variables
          activity_name = file.cell(line, 'M')
          project_length = file.cell(line, 'O')
          project_area = file.cell(line, 'P')
          project_quantity = file.cell(line, 'Q')
          blm_amount = file.cell(line, 'R')
          self_fund_amount = file.cell(line, 'S')
          male_proposal = file.cell(line, 'T')
          female_proposal = file.cell(line, 'U')
          male_beneficiary = file.cell(line, 'V')
          female_beneficiary = file.cell(line, 'W')
          poor_beneficiary = file.cell(line, 'X')
          latitude = file.cell(line, 'Z')
          longitude = file.cell(line, 'Y')
          subdistrict_id = subdistrict.id
          
          # activity = Activity.find(:first, :conditions => {:name => activity_name, :subdistrict_id => subdistrict_id}) 
          # if activity == nil
            Activity.create(:name => activity_name, :project_length => project_length, :project_area => project_area, :project_quantity => project_quantity, :blm_amount => blm_amount, :self_fund_amount => self_fund_amount, :male_proposal => male_proposal, :female_proposal => female_proposal, :male_beneficiary => male_beneficiary, :female_beneficiary => female_beneficiary, :poor_beneficiary => poor_beneficiary, :latitude => latitude, :longitude => longitude, :subdistrict_id => subdistrict_id)
          # end
        end
        
        format.html { redirect_to activities_path }
      else
        format.html { render :action => "new" }
      end
    end
  end
  # end of importing data from excel file
end
