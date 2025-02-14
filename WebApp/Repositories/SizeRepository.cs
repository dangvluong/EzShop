﻿using Dapper;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using WebApp.Interfaces;
using WebApp.Models;

namespace WebApp.Repositories
{
    public class SizeRepository : BaseRepository,ISizeRepository
    {
        //IConfiguration configuration;
        public SizeRepository(IDbConnection connection) : base(connection)
        {
            //this.configuration = configuration;
        }

        public IEnumerable<Size> GetSizes()
        {
            return connection.Query<Size>("GetSizes", commandType: CommandType.StoredProcedure);

        }

        public List<Size> GetSizesByProduct(short productId)
        {
            return connection.Query<Size>("GetSizesByProduct", new { ProductId = productId }, commandType: CommandType.StoredProcedure).ToList();
        }
        public int Edit(Size obj)
        {
            return connection.Execute($"UPDATE Size SET SizeCode = '{obj.SizeCode}' WHERE SizeId = {obj.SizeId}");
        }
        public int Delete(short id)
        {
            return connection.Execute($"UPDATE Size SET IsDeleted = 1 WHERE SizeId = {id}");
        }
        public int Add(Size obj)
        {
            return connection.Execute($"INSERT INTO Size(SizeCode) VALUES('{obj.SizeCode}')");
        }
        public IEnumerable<Statistic> GetBestSellingSizes()
        {
            return connection.Query<Statistic>("GetBestSellingSizes", commandType: CommandType.StoredProcedure);
        }
    }
}
