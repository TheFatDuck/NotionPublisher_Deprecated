#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["Lib.Common/Lib.Common.csproj", "Lib.Common/"]
RUN dotnet restore "Lib.Common/Lib.Common.csproj"
COPY . .
RUN dotnet build "./Lib.Common/Lib.Common.csproj" -c Release -o /app/build
COPY ["RedmineApi/RedmineApi.csproj", "RedmineApi/"]
RUN dotnet restore "RedmineApi/RedmineApi.csproj"
COPY . .
WORKDIR "/src/RedmineApi"
RUN dotnet build "RedmineApi.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "RedmineApi.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "RedmineApi.dll"]