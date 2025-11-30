import React from 'react';
import { Card, CardContent } from '@/components/ui/card';

export default function StatsCard({ icon: Icon, title, value, subtitle, color = 'blue' }) {
  const colorClasses = {
    blue: 'bg-red-600 text-white',
    green: 'bg-green-600 text-white',
    amber: 'bg-amber-600 text-white',
    purple: 'bg-slate-700 text-white',
  };

  return (
    <Card className="border-2 border-slate-200 hover:shadow-xl hover:border-red-600 transition-all bg-white">
      <CardContent className="p-6">
        <div className="flex items-start justify-between">
          <div className="space-y-2">
            <p className="text-xs font-bold text-slate-600 uppercase tracking-wide">{title}</p>
            <p className="text-4xl font-black text-slate-900">{value}</p>
            {subtitle && <p className="text-sm text-slate-600 font-medium">{subtitle}</p>}
          </div>
          <div className={`w-14 h-14 rounded-lg flex items-center justify-center shadow-lg ${colorClasses[color]}`}>
            <Icon className="w-7 h-7" />
          </div>
        </div>
      </CardContent>
    </Card>
  );
}