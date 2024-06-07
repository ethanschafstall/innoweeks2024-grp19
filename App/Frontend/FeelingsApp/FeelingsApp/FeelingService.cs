using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FeelingsApp
{
    public class FeelingService : IFeelingService
    {
        public Feeling CurrentFeeling { get; set; }
    }
}

