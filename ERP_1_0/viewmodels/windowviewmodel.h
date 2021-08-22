#ifndef WINDOWVIEWMODEL_H
#define WINDOWVIEWMODEL_H

#include <QObject>

#include "viewmodels/abstractviewmodel.h"

namespace erp {
    namespace viewmodels {
        /**
         * @brief The LoginWindowViewModel class
         */

        class WindowViewModel : public AbstractViewModel {

            using SQLModel = erp::models::SQLModel;

            Q_OBJECT

        public:
            WindowViewModel();

        public:
            void SetVisibility(bool value);
            bool GetVisibility() const noexcept;

        signals:
            bool VisibilityChanged(bool value);

        private:
            bool is_visible_{false};
        };

    } // namespace viewodels
} // namespace erp

#endif // WINDOWVIEWMODEL_H
