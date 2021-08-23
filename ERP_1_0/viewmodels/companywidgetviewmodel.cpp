#include "companywidgetviewmodel.h"


namespace erp {
    namespace viewmodels {
        CompanyWidgetViewModel::CompanyWidgetViewModel() :
            AbstractViewModel() {
        }

        void CompanyWidgetViewModel::ConnectSQLModel(
                std::shared_ptr<SQLModel> model) noexcept {
            Refresh();
        }

        void CompanyWidgetViewModel::DisconnectSQLModel(
                std::shared_ptr<SQLModel> model) noexcept {
            Q_UNUSED(model)
        }

        void CompanyWidgetViewModel::Refresh() {
            // FIXME : this code is only a temporary solution
            //         so ith should be removed later
            query_model_ = std::make_shared<QSqlQueryModel>();
            query_model_->setQuery("SELECT CreatedOn,CompanyShortName FROM tbl_Company");

            // Change the header
            query_model_->setHeaderData(0,Qt::Horizontal,"Дата створення");
            query_model_->setHeaderData(2,Qt::Horizontal,"Контрагент");
        }

        // FIXME : temporary code
        std::shared_ptr<QSqlQueryModel>
        CompanyWidgetViewModel::GetTableViewModel() const {
            return query_model_;
        }

        void CompanyWidgetViewModel::OnDatabaseUpdated() {
            Refresh();
        }

    } // naespace views
} // namespace erp
