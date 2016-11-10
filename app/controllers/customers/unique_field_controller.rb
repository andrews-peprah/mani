class Customers::UniqueFieldController < CustomerController

	# Checks whether the fields provided are unqiue
	# @params client
	# @params params
	# @return hash
	def index(client=nil,params=nil)

		# Search for reference
		if params[:reference].present?
			reference = Reference.where(value: params[:reference])

			# if reference is present
			if reference.present?
				#check whether the customer holding the reference is verified
				reference = reference.first
				if reference.customer.is_verified?
				else
					return {
						success: false,
						response: {
							type: "reference_not_verified",
							message: "Reference number hasn't paid"
						}
				}
				end
			else
				return {
						success: false,
						response: {
							type: "reference_absent",
							message: "Reference is not present"
						}
				}
			end
		end


		# Search for telephone number
		if params[:telephone].present?
			telephone = Customer.where(telephone: params[:telephone],
																username: params[:telephone])

			if telephone.present?
				return {
						success: false,
						response: {
							type: "telephone_exists",
							message: "Telephone number is already used"
						}
				}
			end

			if Mani::Provider.get(params[:telephone]) == false
				return {
						success: false,
						response: {
							type: "provider_unsupported",
							message: "Please provide only MTN or Tigo numbers"
						}
					}
			end
		end


		# return hash when eerything is ok
		return {
			success: true,
			response: {
				type: "fields_unique",
				message: "All fields are unique"
				}
		}

	end
end
