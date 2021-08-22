#ifndef ABSTRACTVIEWMODEL_H
#define ABSTRACTVIEWMODEL_H

#include <QObject>

#include "models/sqlmodel.h"

namespace erp {
    namespace viewmodels {
        /**
         * @brief The AbstractViewModel class
         */
        class AbstractViewModel : public QObject {

            using SQLModel = erp::models::SQLModel;

            Q_OBJECT

        public:
            AbstractViewModel();

        public:
            std::shared_ptr<SQLModel> GetSQLModel() const noexcept;
            void SetSQLModel(std::shared_ptr<SQLModel> value);

        signals:
            void SQLModelChanged();

        protected:
            virtual void ConnectSQLModel(std::shared_ptr<SQLModel> view) noexcept = 0;
            virtual void DisconnectSQLModel(std::shared_ptr<SQLModel> view) noexcept = 0;

        private:
            std::shared_ptr<SQLModel> sql_model_;
        };
    } // namespace viewodels
} // namespace erp

#endif // ABSTRACTVIEWMODEL_H
