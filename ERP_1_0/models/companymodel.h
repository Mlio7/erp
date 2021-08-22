#ifndef ERP_MODELS_COMPANYMODEL_H
#define ERP_MODELS_COMPANYMODEL_H

#include "models/sqlmodel.h"

namespace erp {
    namespace models {
        /**
         * @brief The CompanyModel class is used to retrieve data
         * about companies from the database
         */
        class CompanyModel {
        public:
            /**
             * @brief The Company struct
             */
            // TODO : add more info
            struct Company {
                QString name;
            };

        public:
            explicit CompanyModel(std::shared_ptr<SQLModel> sql_model);

        public:
            QVector<Company> getCompanies() const noexcept;

        private:
            std::shared_ptr<SQLModel> sql_model_;
        };
    } // namespace models
} // namespace erp

#endif // ERP_MODELS_COMPANYMODEL_H
