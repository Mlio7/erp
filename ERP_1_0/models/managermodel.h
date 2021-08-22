#ifndef ERP_MODELS_MANAGERMODEL_H
#define ERP_MODELS_MANAGERMODEL_H

#include "models/sqlmodel.h"

namespace erp {
    namespace models {
        /**
         * @brief The ManagerModel class is used to retrieve data
         * about managers from the database
         */
        class ManagerModel {
        public:
            /**
             * @brief The Manager struct
             */
            // TODO : add more info
            struct Manager {
                QString name;
                QString surname;
                uint8_t age;
            };

        public:
            explicit ManagerModel(std::shared_ptr<SQLModel> sql_model);

        public:
            QVector<Manager> getManagers() const noexcept;

        private:
            std::shared_ptr<SQLModel> sql_model_;
        };
    } // namespace models
} // namespace erp

#endif // ERP_MODELS_MANAGERMODEL_H
