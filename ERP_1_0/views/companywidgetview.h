#ifndef COMPANYWIDGETVIEW_H
#define COMPANYWIDGETVIEW_H
#include <QWidget>

//#include "views/addcompanydialogview.h"
#include "viewmodels/companywidgetviewmodel.h"
#include "ui_companywidget.h"

namespace erp {
    namespace views {

        class CompanyWidgetView : public QWidget {
            using CompanyWidgetViewModel = erp::viewmodels::CompanyWidgetViewModel;

            Q_OBJECT

        public:
            explicit CompanyWidgetView(QWidget *parent = nullptr);

        public:
            std::shared_ptr<CompanyWidgetViewModel> GetViewModel() const noexcept;

        protected:
            virtual void Init();

        public slots:
            void OnAddCompanyButtonClicked();
            void OnSQLModelChanged();

        private:
            std::unique_ptr<Ui::CompanyWidget> ui_;
            //std::shared_ptr<AddOrderDialogView> add_order_dialog_;

            std::shared_ptr<CompanyWidgetViewModel> view_model_;
        };



    } // naespace views
} // namespace erp
#endif // COMPANYWIDGETVIEW_H
