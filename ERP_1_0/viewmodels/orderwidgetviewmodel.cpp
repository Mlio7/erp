#include "orderwidgetviewmodel.h"

namespace erp {
    namespace viewmodels {
        OrderWidgetViewModel::OrderWidgetViewModel() :
            AbstractViewModel() {

        }

        void OrderWidgetViewModel::ConnectSQLModel(
                std::shared_ptr<SQLModel> view) noexcept {
            Q_UNUSED(view)
        }

        void OrderWidgetViewModel::DisconnectSQLModel(
                std::shared_ptr<SQLModel> view) noexcept {
            Q_UNUSED(view)
        }

        // FIXME : temporary code
        std::shared_ptr<QSqlQueryModel>
        OrderWidgetViewModel::GetTableViewModel() const {
            return query_model_;
        }

        void OrderWidgetViewModel::OnDatabaseUpdated() {
            // FIXME : this code is only a temporary solution
            //         so ith should be removed later
            query_model_ = std::make_shared<QSqlQueryModel>();
            query_model_->setQuery("SELECT * FROM tbl_Order");

            // Change the header
            //query_model_->setHeaderData(0,Qt::Horizontal,"Дата створення");
            //query_model_->setHeaderData(1,Qt::Horizontal,"Відповідальний");
            //query_model_->setHeaderData(2,Qt::Horizontal,"Постачальник");
        }
    } // namespace viewodels
} // namespace erp
