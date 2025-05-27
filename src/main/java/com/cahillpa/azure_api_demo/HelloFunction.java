package com.cahillpa.azure_api_demo;

import com.microsoft.azure.functions.*;
import com.microsoft.azure.functions.annotation.*;
import java.util.Optional;

public class HelloFunction {
    @FunctionName("hello")
    public HttpResponseMessage run(
            @HttpTrigger(name = "req", methods = {HttpMethod.GET}, authLevel = AuthorizationLevel.ANONYMOUS)
            HttpRequestMessage<Optional<String>> request,
            ExecutionContext context
    ) {
        context.getLogger().info("Hello function triggered.");
        return request.createResponseBuilder(HttpStatus.OK).body("Hello, world!").build();
    }
}