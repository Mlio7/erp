#include "windowviewmodel.h"

namespace erp {
    namespace viewmodels {
        WindowViewModel::WindowViewModel() :
            AbstractViewModel() {

        }

        void WindowViewModel::SetVisibility(bool value) {
            if (is_visible_ != value) {
                is_visible_ = value;

                emit VisibilityChanged(value);
            }
        }

        bool WindowViewModel::GetVisibility() const noexcept {
            return is_visible_;
        }
    } // namespace viewodels
} // namespace erp
