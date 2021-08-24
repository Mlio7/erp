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
            //RAW SELECT
            //query_model_->setQuery("SELECT CreatedOn,InvoiceNumber,ResponsibleUserID,CompanyID,"
            //                            "OrderDocumentStateTypeID,SumNoVAT,SumVAT,"
            //                            "OrderBillStateTypeID,DeliveryStateTypeID FROM [ERP].[dbo].[tbl_Order]");

            // Change the header
            //query_model_->setHeaderData(0,Qt::Horizontal,"Дата створення");
            //query_model_->setHeaderData(1,Qt::Horizontal,"№ Замовлення");
            //query_model_->setHeaderData(2,Qt::Horizontal,"Відповідальний");
            //query_model_->setHeaderData(3,Qt::Horizontal,"Контрагент");
            //query_model_->setHeaderData(4,Qt::Horizontal,"Документ");
            //query_model_->setHeaderData(5,Qt::Horizontal,"Сума без ПДВ");
            //query_model_->setHeaderData(6,Qt::Horizontal,"Сума з ПДВ");
            //query_model_->setHeaderData(7,Qt::Horizontal,"Стан оплати");
            //query_model_->setHeaderData(8,Qt::Horizontal,"Стан відгрузки");
            //VIEW SELECT
            query_model_->setQuery("SELECT CreatedOn,InvoiceNumber,ResponsibleUser,Company,"
                                        "DocumentState,SumNoVAT,SumVAT,"
                                        "BillState,DeliveryState FROM [ERP].[dbo].[vw_Order]");

            query_model_->setHeaderData(0,Qt::Horizontal,"Дата створення");
            query_model_->setHeaderData(1,Qt::Horizontal,"№ Замовлення");
            query_model_->setHeaderData(2,Qt::Horizontal,"Відповідальний");
            query_model_->setHeaderData(3,Qt::Horizontal,"Контрагент");
            query_model_->setHeaderData(4,Qt::Horizontal,"Документ");
            query_model_->setHeaderData(5,Qt::Horizontal,"Сума без ПДВ");
            query_model_->setHeaderData(6,Qt::Horizontal,"Сума з ПДВ");
            query_model_->setHeaderData(7,Qt::Horizontal,"Стан оплати");
            query_model_->setHeaderData(8,Qt::Horizontal,"Стан відгрузки");

            emit DataRefreshed();
        }

        // FIXME : temporary code
        std::shared_ptr<QSqlQueryModel>
        OrderWidgetViewModel::GetTableViewModel() const {
            return query_model_;
        }

        void OrderWidgetViewModel::OnOrdersUpdated() {
            Refresh();
        }
    } // namespace viewodels
} // namespace erp
