#ifndef ERP_MODELS_SQLMODEL_H
#define ERP_MODELS_SQLMODEL_H

#include <QObject>
#include <QtSql>

namespace erp {
    namespace models {
        /**
         * @brief This class is a model for database operations. It is capable of
         * logging in and handling requests to the database.
         */
        class SQLModel : public QObject {

            Q_OBJECT

        public:
            /**
             * @brief The LoginData struct holds data for
             * a login process.
             */
            struct LoginData {
                QString server;
                QString database;
                QString user;
                QString password;
            };

        public:
            SQLModel();

        public:
            void Login(const LoginData& data);
            bool IsLoggedIn() const noexcept;

            std::shared_ptr<QSqlQuery> Request(const QString& value);

        signals:
            void LoginStateChanged(bool value);

        private:
            QSqlDatabase database_;
            LoginData current_data_;
        };
    } // namespace models
} // namespace erp

#endif // ERP_MODELS_SQLMODEL_H
