#include "companymodel.h"

namespace erp {
    namespace models {
        CompanyModel::CompanyModel(std::shared_ptr<SQLModel> sql_model) :
            sql_model_{sql_model} {

        }

        QVector<CompanyModel::Company> CompanyModel::getCompanies() const noexcept {
            // Sanity checks
            if (!sql_model_) return {};
            if (!sql_model_->IsLoggedIn()) return {};

            QVector<Company> companies;
            auto query = sql_model_->Request("SELECT Name FROM tbl_Company");
            while (query->next()) {
                // Fill company info
                // TODO : store more data about a company
                Company company;
                company.name = query->value(0).toString();

                // Push the company into the vector of companies
                companies.push_back(company);
            }

            return companies;
        }
    } // namespace models
} // namespace erp
