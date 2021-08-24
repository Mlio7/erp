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
                //QString name;
                QDateTime timestamp;
                QString manager;
                QString CompanyShortName;
                QString ContactName;
                QString Relationship;
                QString Field;
                QString FieldActivity;
                QString ActivityDirection;
                QString AddressType;
                QString Continent;
                QString Country;
                //QString State;
                //QString City;
                QString Communication_CellNumber;
                QString Communication_PhoneNumber;
                QString Communication_FaxNumber;
                QString Communication_Email;
                QString Communication_Web;
                qint32 SumVAT;
                QString BillState;
                QString DeliveryState;
            };

        public:
            explicit CompanyModel(std::shared_ptr<SQLModel> sql_model);

        public:
            QVector<Company> getCompanies() const noexcept;
            QVector<Company> getManagerCompanies(const QString& manager) const noexcept;

        private:
            std::shared_ptr<SQLModel> sql_model_;
        };
    } // namespace models
} // namespace erp

#endif // ERP_MODELS_COMPANYMODEL_H
