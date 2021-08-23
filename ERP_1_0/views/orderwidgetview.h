#ifndef ERP_VIEWS_ORDERWIDGETVIEW_H
#define ERP_VIEWS_ORDERWIDGETVIEW_H

#include <QWidget>

#include "views/addorderdialogview.h"

#include "viewmodels/orderwidgetviewmodel.h"

#include "ui_orderwidget.h"

namespace erp {
    namespace views {
        /**
         * @brief The MainWindowView class
         */
        class OrderWidgetView : public QWidget {

            using OrderWidgetViewModel = erp::viewmodels::OrderWidgetViewModel;

            Q_OBJECT

        public:
            explicit OrderWidgetView(QWidget *parent = nullptr);

        public:
            std::shared_ptr<OrderWidgetViewModel> GetViewModel() const noexcept;

        protected:
            virtual void Init();

        public slots:
            void OnAddOrderButtonClicked();
            void OnSQLModelChanged();

        private:
            std::unique_ptr<Ui::OrderWidget> ui_;
            std::shared_ptr<AddOrderDialogView> add_order_dialog_;

            std::shared_ptr<OrderWidgetViewModel> view_model_;
        };
    } // naespace views
} // namespace erp

#endif // ERP_VIEWS_ORDERWIDGETVIEW_H
