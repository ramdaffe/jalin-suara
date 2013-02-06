require 'test_helper'

class ImplementerUnitsControllerTest < ActionController::TestCase
  setup do
    @implementer_unit = implementer_units(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:implementer_units)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create implementer_unit" do
    assert_difference('ImplementerUnit.count') do
      post :create, implementer_unit: { address: @implementer_unit.address, blm_amount: @implementer_unit.blm_amount, call_center: @implementer_unit.call_center, facilitator: @implementer_unit.facilitator, facilitator_phone: @implementer_unit.facilitator_phone, female_beneciary: @implementer_unit.female_beneciary, female_proposal: @implementer_unit.female_proposal, male_beneficiary: @implementer_unit.male_beneficiary, male_proposal: @implementer_unit.male_proposal, name: @implementer_unit.name, phone: @implementer_unit.phone, poor_beneficiary: @implementer_unit.poor_beneficiary, project_area: @implementer_unit.project_area, project_id: @implementer_unit.project_id, project_length: @implementer_unit.project_length, project_quantity: @implementer_unit.project_quantity, self_fund_amount: @implementer_unit.self_fund_amount, subdistrict_id: @implementer_unit.subdistrict_id }
    end

    assert_redirected_to implementer_unit_path(assigns(:implementer_unit))
  end

  test "should show implementer_unit" do
    get :show, id: @implementer_unit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @implementer_unit
    assert_response :success
  end

  test "should update implementer_unit" do
    put :update, id: @implementer_unit, implementer_unit: { address: @implementer_unit.address, blm_amount: @implementer_unit.blm_amount, call_center: @implementer_unit.call_center, facilitator: @implementer_unit.facilitator, facilitator_phone: @implementer_unit.facilitator_phone, female_beneciary: @implementer_unit.female_beneciary, female_proposal: @implementer_unit.female_proposal, male_beneficiary: @implementer_unit.male_beneficiary, male_proposal: @implementer_unit.male_proposal, name: @implementer_unit.name, phone: @implementer_unit.phone, poor_beneficiary: @implementer_unit.poor_beneficiary, project_area: @implementer_unit.project_area, project_id: @implementer_unit.project_id, project_length: @implementer_unit.project_length, project_quantity: @implementer_unit.project_quantity, self_fund_amount: @implementer_unit.self_fund_amount, subdistrict_id: @implementer_unit.subdistrict_id }
    assert_redirected_to implementer_unit_path(assigns(:implementer_unit))
  end

  test "should destroy implementer_unit" do
    assert_difference('ImplementerUnit.count', -1) do
      delete :destroy, id: @implementer_unit
    end

    assert_redirected_to implementer_units_path
  end
end
