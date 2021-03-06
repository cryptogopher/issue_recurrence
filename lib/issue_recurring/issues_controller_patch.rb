module IssueRecurring
  module IssuesControllerPatch
    IssuesController.class_eval do
      before_action :prepare_recurrences, :only => [:show]

      private

      def prepare_recurrences
        @recurrences = @issue.recurrences.select {|r| r.visible?}
        @recurrence = IssueRecurrence.new(
          anchor_to_start: @issue.start_date.present? && @issue.due_date.blank?
        )
        @recurrence_copies = @issue.recurrence_copies
        @next_dates = IssueRecurrence.issue_dates(@issue)
        @predicted_dates = IssueRecurrence.issue_dates(@issue, true)
      end
    end
  end
end

