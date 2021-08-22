#ifndef ERP_VIEWMODELS_ORDERWIDGETVIEWMODEL_H
#define ERP_VIEWMODELS_ORDERWIDGETVIEWMODEL_H

#include <QObject>
#include <QSqlQueryModel>

#include "models/sqlmodel.h"
#include "models/ordermodel.h"

#include "viewmodels/abstractviewmodel.h"

namespace erp {
    namespace viewmodels {
        /**
         * @brief The OrderWidgetViewModel class
         */
        class OrderWidgetViewModel : public AbstractViewModel {

            using SQLModel = erp::models::SQLModel;
            using OrderModel = erp::models::OrderModel;

            Q_OBJECT

        public:
            OrderWidgetViewModel();

        public:
            // FIXME : should be replaced
            std::shared_ptr<QSqlQueryModel> GetTableViewModel() const;

        public slots:
            void OnDatabaseUpdated();

        signals:
            void ModelUpdated();

        protected:
            virtual void ConnectSQLModel(
                    std::shared_ptr<SQLModel> view) noexcept override;
            virtual void DisconnectSQLModel(
                    std::shared_ptr<SQLModel> view) noexcept override;

        private:
            // FIXME : should be used
            std::shared_ptr<QVector<OrderModel>>
            order_vector_{std::make_shared<QVector<OrderModel>>()};

            // FIXME : remove
            mutable std::shared_ptr<QSqlQueryModel> query_model_;
        };
    } // namespace viewodels
} // namespace erp

#endif // ERP_VIEWMODELS_ORDERWIDGETVIEWMODEL_H
