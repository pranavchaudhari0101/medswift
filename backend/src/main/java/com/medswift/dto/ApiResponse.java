package com.medswift.dto;

public class ApiResponse {

    public static class Success<T> {
        private boolean success = true;
        private String message;
        private T data;

        public Success() {
        }

        public Success(boolean success, String message, T data) {
            this.success = success;
            this.message = message;
            this.data = data;
        }

        public boolean isSuccess() {
            return success;
        }

        public void setSuccess(boolean success) {
            this.success = success;
        }

        public String getMessage() {
            return message;
        }

        public void setMessage(String message) {
            this.message = message;
        }

        public T getData() {
            return data;
        }

        public void setData(T data) {
            this.data = data;
        }

        public static <T> SuccessBuilder<T> builder() {
            return new SuccessBuilder<>();
        }

        public static class SuccessBuilder<T> {
            private boolean success = true;
            private String message;
            private T data;

            public SuccessBuilder<T> success(boolean success) {
                this.success = success;
                return this;
            }

            public SuccessBuilder<T> message(String message) {
                this.message = message;
                return this;
            }

            public SuccessBuilder<T> data(T data) {
                this.data = data;
                return this;
            }

            public Success<T> build() {
                return new Success<>(success, message, data);
            }
        }
    }

    public static class Error {
        private boolean success = false;
        private String message;
        private String error;

        public Error() {
        }

        public Error(boolean success, String message, String error) {
            this.success = success;
            this.message = message;
            this.error = error;
        }

        public boolean isSuccess() {
            return success;
        }

        public void setSuccess(boolean success) {
            this.success = success;
        }

        public String getMessage() {
            return message;
        }

        public void setMessage(String message) {
            this.message = message;
        }

        public String getError() {
            return error;
        }

        public void setError(String error) {
            this.error = error;
        }

        public static ErrorBuilder builder() {
            return new ErrorBuilder();
        }

        public static class ErrorBuilder {
            private boolean success = false;
            private String message, error;

            public ErrorBuilder success(boolean success) {
                this.success = success;
                return this;
            }

            public ErrorBuilder message(String message) {
                this.message = message;
                return this;
            }

            public ErrorBuilder error(String error) {
                this.error = error;
                return this;
            }

            public Error build() {
                return new Error(success, message, error);
            }
        }
    }

    public static class PagedResponse<T> {
        private boolean success = true;
        private T data;
        private int page;
        private int size;
        private long totalElements;
        private int totalPages;

        public PagedResponse() {
        }

        public PagedResponse(boolean success, T data, int page, int size, long totalElements, int totalPages) {
            this.success = success;
            this.data = data;
            this.page = page;
            this.size = size;
            this.totalElements = totalElements;
            this.totalPages = totalPages;
        }

        public boolean isSuccess() {
            return success;
        }

        public void setSuccess(boolean success) {
            this.success = success;
        }

        public T getData() {
            return data;
        }

        public void setData(T data) {
            this.data = data;
        }

        public int getPage() {
            return page;
        }

        public void setPage(int page) {
            this.page = page;
        }

        public int getSize() {
            return size;
        }

        public void setSize(int size) {
            this.size = size;
        }

        public long getTotalElements() {
            return totalElements;
        }

        public void setTotalElements(long totalElements) {
            this.totalElements = totalElements;
        }

        public int getTotalPages() {
            return totalPages;
        }

        public void setTotalPages(int totalPages) {
            this.totalPages = totalPages;
        }

        public static <T> PagedResponseBuilder<T> builder() {
            return new PagedResponseBuilder<>();
        }

        public static class PagedResponseBuilder<T> {
            private boolean success = true;
            private T data;
            private int page, size, totalPages;
            private long totalElements;

            public PagedResponseBuilder<T> success(boolean success) {
                this.success = success;
                return this;
            }

            public PagedResponseBuilder<T> data(T data) {
                this.data = data;
                return this;
            }

            public PagedResponseBuilder<T> page(int page) {
                this.page = page;
                return this;
            }

            public PagedResponseBuilder<T> size(int size) {
                this.size = size;
                return this;
            }

            public PagedResponseBuilder<T> totalElements(long totalElements) {
                this.totalElements = totalElements;
                return this;
            }

            public PagedResponseBuilder<T> totalPages(int totalPages) {
                this.totalPages = totalPages;
                return this;
            }

            public PagedResponse<T> build() {
                return new PagedResponse<>(success, data, page, size, totalElements, totalPages);
            }
        }
    }
}
