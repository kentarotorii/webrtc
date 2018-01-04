module ReportsHelper
  def choose_new_or_edit
    if action_name == 'new'
      binding.pry
      consultation_reports_path
    elsif action_name == 'edit'
      binding.pry
      consultation_report_path(@consultation, @report)
      #{:controller => 'reports', :action => 'update'}
    end
  end
end
