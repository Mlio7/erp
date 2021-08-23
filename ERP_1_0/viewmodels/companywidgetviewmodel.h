#ifndef COMPANYWIDGETVIEWMODEL_H
#define COMPANYWIDGETVIEWMODEL_H

#include <QObject>
#include <QSqlQueryModel>

#include "models/sqlmodel.h"
#include "models/companymodel.h"

#include "viewmodels/abstractviewmodel.h"

namespace erp {
    namespace viewmodels {
        /**
         * @brief The OrderWidgetViewModel class
         */
        class CompanyWidgetViewModel : public AbstractViewModel {

            using SQLModel = erp::models::SQLModel;
            using CompanyModel = erp::models::CompanyModel;

            Q_OBJECT

        public:
            CompanyWidgetViewModel();

        public:
            // FIXME : should be replaced
            std::shared_ptr<QSqlQueryModel> GetTableViewModel() const;

        public slots:
            void OnDatabaseUpdated();

        protected:
            virtual void ConnectSQLModel(
                    std::shared_ptr<SQLModel> model) noexcept override;
            virtual void DisconnectSQLModel(
                    std::shared_ptr<SQLModel> model) noexcept override;

        private:
            void Refresh();

        private:
            // FIXME : should be used
            std::shared_ptr<QVector<CompanyModel>>
            order_vector_{std::make_shared<QVector<CompanyModel>>()};

            // FIXME : remove
            mutable std::shared_ptr<QSqlQueryModel> query_model_;
        };
    } // namespace viewodels
} // namespace erp

#endif // COMPANYWIDGETVIEWMODEL_H
