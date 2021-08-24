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
            query_model_->setQuery("SELECT * FROM vw_Company");

            // Change the header
            query_model_->setHeaderData(0,Qt::Horizontal,"Дата створення");
            query_model_->setHeaderData(1,Qt::Horizontal,"Відповідальний");
            query_model_->setHeaderData(2,Qt::Horizontal,"Контрагент");
            query_model_->setHeaderData(3,Qt::Horizontal,"Контакт");
            query_model_->setHeaderData(4,Qt::Horizontal,"Тип відносин");
            query_model_->setHeaderData(5,Qt::Horizontal,"Вид діяльності");
            query_model_->setHeaderData(6,Qt::Horizontal,"Сфера діяльності");
            query_model_->setHeaderData(7,Qt::Horizontal,"Напрямок діяльності");
            query_model_->setHeaderData(8,Qt::Horizontal,"Тип адреси");
            query_model_->setHeaderData(9,Qt::Horizontal,"Континент");
            query_model_->setHeaderData(10,Qt::Horizontal,"Країна");
            //query_model_->setHeaderData(2,Qt::Horizontal,"Регіон");
            //query_model_->setHeaderData(2,Qt::Horizontal,"Населений пункт");
            query_model_->setHeaderData(11,Qt::Horizontal,"Індекс");
            query_model_->setHeaderData(12,Qt::Horizontal,"Мобільний");
            query_model_->setHeaderData(13,Qt::Horizontal,"Стаціонарний");
            query_model_->setHeaderData(14,Qt::Horizontal,"Факс");
            query_model_->setHeaderData(15,Qt::Horizontal,"Email");
            query_model_->setHeaderData(16,Qt::Horizontal,"Сайт");
            query_model_->setHeaderData(17,Qt::Horizontal,"Активний");
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
