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
            auto query = sql_model_->Request("SELECT * FROM vw_Company");
            while (query->next()) {
                // Fill company info
                // TODO : store more data about a company
                Company company;
                company.CompanyShortName = query->value(2).toString();

                // Push the company into the vector of companies
                companies.push_back(company);
            }

            return companies;
        }

        QVector<CompanyModel::Company> CompanyModel::getManagerCompanies(const QString& manager) const noexcept {
            // Sanity checks
            if (!sql_model_) return {};
            if (!sql_model_->IsLoggedIn()) return {};
            if (manager.isEmpty()) return {};

            QVector<Company> companies;
            auto query = sql_model_->Request("\
                         SELECT [dbo].[tbl_Company].[CompanyShortName]\
                         FROM  [ERP].[dbo].[tbl_Company]\
                         JOIN  [dbo].[tbl_Users] ON  [dbo].[tbl_Company].[ResponsibleUserID] = [dbo].[tbl_Users].[ID] \
                         where [dbo].[tbl_Users].[Name]= \'" + manager + "\' ");




            while (query->next()) {
                // Fill company info
                // TODO : store more data about a company
                Company company;
                company.CompanyShortName = query->value(0).toString();

                // Push the company into the vector of companies
                companies.push_back(company);
            }

            return companies;
        }
    } // namespace models
} // namespace erp



