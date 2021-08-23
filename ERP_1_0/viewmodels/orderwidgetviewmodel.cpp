#include "orderwidgetviewmodel.h"

namespace erp {
    namespace viewmodels {
        OrderWidgetViewModel::OrderWidgetViewModel() :
            AbstractViewModel() {
        }

        void OrderWidgetViewModel::ConnectSQLModel(
                std::shared_ptr<SQLModel> model) noexcept {
            Refresh();
        }

        void OrderWidgetViewModel::DisconnectSQLModel(
                std::shared_ptr<SQLModel> model) noexcept {
            Q_UNUSED(model)
        }

        void OrderWidgetViewModel::Refresh() {
            // FIXME : this code is only a temporary solution
            //         so ith should be removed later
            query_model_ = std::make_shared<QSqlQueryModel>();
            query_model_->setQuery("SELECT CreatedOn,Manager,CompanyName FROM tbl_Order");

            // Change the header
            query_model_->setHeaderData(0,Qt::Horizontal,"Дата створення");
            query_model_->setHeaderData(1,Qt::Horizontal,"Відповідальний");
            query_model_->setHeaderData(2,Qt::Horizontal,"Постачальник");

            emit DataRefreshed();
        }

        // FIXME : temporary code
        std::shared_ptr<QSqlQueryModel>
        OrderWidgetViewModel::GetTableViewModel() const {
            return query_model_;
        }

        void OrderWidgetViewModel::OnDatabaseUpdated() {
            Refresh();
        }
    } // namespace viewodels
} // namespace erp
