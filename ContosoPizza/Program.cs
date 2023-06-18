using ContosoPizza.Data;
using ContosoPizza.Services;
using Microsoft.EntityFrameworkCore;

// Additional using declarations

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Lambda support
builder.Services.AddAWSLambdaHosting(LambdaEventSource.RestApi);

// Add the PizzaContext
builder.Services.AddDbContext<PizzaContext>(options =>
{
    options.UseNpgsql(GetConnetionString()
    );

    static string GetConnetionString()
    {
        return "Host="+Environment.GetEnvironmentVariable("DBHost")+";Username="+Environment.GetEnvironmentVariable("DBUserName")+";Password="+Environment.GetEnvironmentVariable("DBPassword")+";Database="+Environment.GetEnvironmentVariable("DBName");
    }
});

builder.Services.AddScoped<PizzaService>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseAuthorization();

app.MapControllers();

// Add the CreateDbIfNotExists method call
app.CreateDbIfNotExists();

app.MapGet("/", () => @"Contoso Pizza management API. Navigate to /swagger to open the Swagger test UI.");
app.Run();