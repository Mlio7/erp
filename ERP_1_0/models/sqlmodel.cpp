#include "sqlmodel.h"

namespace erp {
    namespace models {
        SQLModel::SQLModel() :
            QObject() {

        }

        void SQLModel::Login(const LoginData& data) {
            // TODO : make the type of the database changable
            database_ = QSqlDatabase::addDatabase("QODBC");
            database_.setDatabaseName("DRIVER={SQL Server};SERVER="
                                      + data.server
                                      + ";DATABASE="
                                      + data.database+";");
            database_.setUserName(data.user);
            database_.setPassword(data.password);

            // Try to login
            database_.open();
            emit LoginStateChanged(IsLoggedIn());
        }

        bool SQLModel::IsLoggedIn() const noexcept {
            return database_.isOpen();
        }

        std::shared_ptr<QSqlQuery> SQLModel::Request(const QString& value) {
            // Sanity check
            if (!database_.isValid() || !IsLoggedIn() || value.isEmpty())
                return {};  // {} = std::shared_ptr<QSqlQuery>

            // This code will try to create a new entry in database
            // query of commands. Then the command will be executed
            // by firing the exec() method.
            auto query = std::make_shared<QSqlQuery>(database_);    // auto query = new QSqlQuery(database_);
            query->exec(value);

            return query;
        }
    } // namespace models
} // namespace erp
