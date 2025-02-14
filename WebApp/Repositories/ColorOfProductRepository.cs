﻿using Dapper;
using System.Collections.Generic;
using System.Data;
using WebApp.Interfaces;
using WebApp.Models;

namespace WebApp.Repositories
{
    public class ColorOfProductRepository : BaseRepository,IColorOfProductRepository
    {
        public ColorOfProductRepository(IDbConnection connection) : base(connection) { }
        public int Edit(List<ColorOfProduct> list, short productId)
        {            
            connection.Execute($"DELETE FROM ColorOfProduct WHERE ProductId = {productId}");
            return connection.Execute("AddColorOfProduct", list, commandType: CommandType.StoredProcedure);
        }

        public int Add(List<ColorOfProduct> list)
        {            
            return connection.Execute("AddColorOfProduct", list, commandType: CommandType.StoredProcedure);
        }
    }
}
