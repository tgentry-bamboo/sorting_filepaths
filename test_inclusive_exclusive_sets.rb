require 'minitest/autorun'
require 'pry'
require_relative 'inclusive_exclusive_set_builder.rb'

class TestInclusiveExclusiveSetBuilder < Minitest::Test
	def setup
		@set_builder = InclusiveExclusiveSetBuilder.new(left, right)
		@left_count = 29
		@right_count = 31
		@inclusive_set = ["spec/config/initializers/rack_attack_spec.rb", "spec/features/insight_reports_spec.rb",
			"spec/features/unsolicited_report_spec.rb", "spec/models/rx_search_request_spec.rb", 
			"spec/models/users/user_spec.rb"]
		@exclusive_left = exclusive_left
		@exclusive_right = exclusive_right
	end

	def test_that_left_input_is_valid
		left_lines = @set_builder.left_lines

		assert_equal left_lines.count, @left_count
	end

	def test_that_right_input_is_valid
		right_lines = @set_builder.right_lines

		assert_equal right_lines.count, @right_count
	end

	def test_that_parsed_inputs_are_ruby_filepaths
		assert @set_builder.left_lines.all? { |line| line[-2..] == 'rb' }
		assert @set_builder.right_lines.all? { |line| line[-2..] == 'rb' }
	end

	def test_that_each_set_is_uniq
		assert @set_builder.left_lines.uniq.count @left_count
		assert @set_builder.right_lines.uniq.uniq.count @right_count
	end

	def test_that_sets_contain_any_similarities
		assert @set_builder.similar?
	end

	def test_that_similar_items_form_an_inclusive_set
		# You can replace this entire logic with a boolean (&) operator but then how would we test it :)
		combined = @set_builder.combined.sort
		matched_items = []

		combined.each_with_index do |filename, idx|
			matched_items << filename

			if (matched_items.include? combined[idx + 1]) || idx + 1 > combined.count
				next
			else
				matched_items.pop
			end
		end

		assert_equal matched_items, @inclusive_set
	end

	def test_that_similar_items_are_removed_from_the_left_exclusive_set
		assert_equal @set_builder.exclusive_left, @exclusive_left
	end

	def test_that_similar_items_are_removed_from_the_right_exclusive_set
		assert_equal @set_builder.exclusive_right, @exclusive_right
	end

	def left
"spec/services/rx_search/search_request_spec.rb
spec/helpers/mailer_helper_spec.rb
spec/helpers/bulk_patient_searches_helper_spec.rb
spec/adapters/narx_com/api_adapter_spec.rb
spec/models/overdose_death_alert_request_spec.rb
spec/models/my_rx_request_spec.rb
spec/models/alias_name_criterium_spec.rb
spec/models/rx_search_request_spec.rb
spec/models/investigative_search_request_spec.rb
spec/features/insight_reports_spec.rb
spec/features/investigative_search_output_spec.rb
spec/features/demographics_office_dispensation_inquiry_spec.rb
spec/features/unsolicited_report_spec.rb
spec/features/pharmacy_rx_search_spec.rb
spec/features/approval_of_new_jersey_cma_unlicensed_spec.rb
spec/features/validation_documents_for_settings_change_spec.rb
spec/features/edit_user_email_spec.rb
spec/features/registration_for_new_jersey_cma_unlicensed_spec.rb
spec/features/lexis_nexis_identity_quiz_spec.rb
spec/controllers/patient_alerts_controller_spec.rb
spec/config/initializers/rack_attack_spec.rb
spec/controllers/rx_search_requests/manual_consolidation_patient_groups_controller_spec.rb
spec/controllers/delegates_controller_spec.rb
spec/models/users/user_spec.rb
spec/models/identity_spec.rb
spec/models/opioid_benzodiazepine_alert_request_spec.rb
spec/models/mat_missed_days_supply_alert_request_spec.rb
spec/lib/validation_configuration_verifier_spec.rb
spec/support/shared_contexts.rb"
	end

	def right
"spec/lib/clearinghouse/sqs_adapter_spec.rb
spec/lib/clearinghouse/sqs_config_spec.rb
spec/lib/dea_service_with_last_name_and_configurable_expired_spec.rb
spec/helpers/admin/role_permissions_helper_spec.rb
spec/helpers/error_correction_helper_spec.rb
spec/features/insight_reports_spec.rb
spec/config/initializers/rack_attack_spec.rb
spec/features/unsolicited_report_spec.rb
spec/features/contested_record_spec.rb
spec/requests/users_spec.rb
spec/requests/agreement_spec.rb
spec/requests/appriss/admin/batch_imports/medical_marijuana_import_request_spec.rb
spec/requests/appriss/admin/batch_imports/state_licensees_request_spec.rb
spec/requests/appriss/admin/batch_imports/saw_users_request_spec.rb
spec/workers/periodic/auto_registration_rejection_worker_spec.rb
spec/models/pharmacy_spec.rb
spec/models/delinquent_dispenser_request_spec.rb
spec/models/application_preference_spec.rb
spec/models/validation_template_spec.rb
spec/models/database_job_spec.rb
spec/models/rx_search_request_spec.rb
spec/models/patient_consolidation_result_spec.rb
spec/models/current_pmp/features/tile_view_spec.rb
spec/models/current_pmp/features/movable_tiles_spec.rb
spec/models/users/user_spec.rb
spec/models/users/user_validation_spec.rb
spec/models/delegate_spec.rb
spec/models/mailing_template_spec.rb
spec/models/prescriber_dispensary_alert_request_spec.rb
spec/models/clinical_alert_config_spec.rb
spec/models/report_output_spec.rb"
	end

	def exclusive_left
		# rg --files-with-matches "flickering"
		# These are files with "flickering" tests
		["spec/services/rx_search/search_request_spec.rb",
		 "spec/helpers/mailer_helper_spec.rb",
		 "spec/helpers/bulk_patient_searches_helper_spec.rb",
		 "spec/adapters/narx_com/api_adapter_spec.rb",
		 "spec/models/overdose_death_alert_request_spec.rb",
		 "spec/models/my_rx_request_spec.rb",
		 "spec/models/alias_name_criterium_spec.rb",
		 "spec/models/investigative_search_request_spec.rb",
		 "spec/features/investigative_search_output_spec.rb",
		 "spec/features/demographics_office_dispensation_inquiry_spec.rb",
		 "spec/features/pharmacy_rx_search_spec.rb",
		 "spec/features/approval_of_new_jersey_cma_unlicensed_spec.rb",
		 "spec/features/validation_documents_for_settings_change_spec.rb",
		 "spec/features/edit_user_email_spec.rb",
		 "spec/features/registration_for_new_jersey_cma_unlicensed_spec.rb",
		 "spec/features/lexis_nexis_identity_quiz_spec.rb",
		 "spec/controllers/patient_alerts_controller_spec.rb",
		 "spec/controllers/rx_search_requests/manual_consolidation_patient_groups_controller_spec.rb",
		 "spec/controllers/delegates_controller_spec.rb",
		 "spec/models/identity_spec.rb",
		 "spec/models/opioid_benzodiazepine_alert_request_spec.rb",
		 "spec/models/mat_missed_days_supply_alert_request_spec.rb",
		 "spec/lib/validation_configuration_verifier_spec.rb",
		 "spec/support/shared_contexts.rb"]
	end

	def exclusive_right
		# rg --files-with-matches "broken: true"
		# These are files with "broken" tests
		["spec/lib/clearinghouse/sqs_adapter_spec.rb",
		 "spec/lib/clearinghouse/sqs_config_spec.rb",
		 "spec/lib/dea_service_with_last_name_and_configurable_expired_spec.rb",
		 "spec/helpers/admin/role_permissions_helper_spec.rb",
		 "spec/helpers/error_correction_helper_spec.rb",
		 "spec/features/contested_record_spec.rb",
		 "spec/requests/users_spec.rb",
		 "spec/requests/agreement_spec.rb",
		 "spec/requests/appriss/admin/batch_imports/medical_marijuana_import_request_spec.rb",
		 "spec/requests/appriss/admin/batch_imports/state_licensees_request_spec.rb",
		 "spec/requests/appriss/admin/batch_imports/saw_users_request_spec.rb",
		 "spec/workers/periodic/auto_registration_rejection_worker_spec.rb",
		 "spec/models/pharmacy_spec.rb",
		 "spec/models/delinquent_dispenser_request_spec.rb",
		 "spec/models/application_preference_spec.rb",
		 "spec/models/validation_template_spec.rb",
		 "spec/models/database_job_spec.rb",
		 "spec/models/patient_consolidation_result_spec.rb",
		 "spec/models/current_pmp/features/tile_view_spec.rb",
		 "spec/models/current_pmp/features/movable_tiles_spec.rb",
		 "spec/models/users/user_validation_spec.rb",
		 "spec/models/delegate_spec.rb",
		 "spec/models/mailing_template_spec.rb",
		 "spec/models/prescriber_dispensary_alert_request_spec.rb",
		 "spec/models/clinical_alert_config_spec.rb",
		 "spec/models/report_output_spec.rb"]
	end

	def inclusive_set
		# These are files with "flickering" and "broken: true" tests
		# Difficult to grep, I know
		["spec/config/initializers/rack_attack_spec.rb", 
			"spec/features/insight_reports_spec.rb",
			"spec/features/unsolicited_report_spec.rb",
			"spec/models/rx_search_request_spec.rb", 
			"spec/models/users/user_spec.rb"]
	end
end
